# frozen_string_literal: true

require "thor"
require "awesome_print"
require "rainbow"
require "active_support/all"
require_relative "concerns/commandable"
require_relative "concerns/configurable"
require_relative "generator/cli"

module Containers
  class CLI < Thor
    include Commandable
    include Configurable

    Dir["commands/**/*.rb", base: __dir__].each { |f| require_relative f }

    desc "generate", "Commands used to generate files for the project"
    long_desc "Also aliased as `init`"
    subcommand "generate", Generator::CLI
    map "init" => :generate

    protected

    def container_name(service_name = docker_default_service)
      return nil unless service_name
      "#{app_name}-#{service_name}"
    end

    def service_name(container_name)
      return nil unless container_name
      container_name.sub(/\A#{app_name}-/, "")
    end

    def service_names
      `containers list -s`.split("\n").reject do |line|
        line.nil? || line.empty? || line.include?(Containers::Commandable::PREFIX)
      end
    end

    def container_names
      `containers list`.split("\n").reject do |line|
        line.nil? || line.empty? || line.include?(Containers::Commandable::PREFIX)
      end
    end

    def requested_container_names(*args)
      # explicitly requested container option
      list = options[:container] if options[:container]

      # determine container names based on service names
      list ||= requested_service_names(*args).map { |name| container_name name }

      # fallback to all known container names
      list = container_names if list.none?

      list.each { |name| yield name if name.present? } if block_given?
      list
    end

    def requested_service_names(*args)
      # explicitly requested service option
      list = options[:service] if options[:service]

      # extract service names from passed arguments
      list ||= extract_service_names(*args).map { |name| service_name name }

      # determine service names based on container names
      list ||= requested_container_names(*args).map { |name| service_name name } if options[:container]

      # fallback to all known service names
      list = service_names if list.none?

      list.each { |name| yield name if name.present? } if block_given?
      list
    end

    def sanitize_args(*args)
      services = extract_service_names(*args)
      args.shift while args.any? && services.include?(args.first)
      args.select(&:present?)
    end

    private

    def extract_service_names(*args)
      services = []
      services.push args.shift until args.none? || args.first.start_with?("-")
      services
    end
  end
end
