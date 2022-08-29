# frozen_string_literal: true

require "pry-byebug"
require "thor"
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
    subcommand "generate", Generator::CLI

    protected

    def container_name(service_name)
      return nil unless service_name
      "#{project_name}-#{service_name}"
    end

    def service_name(container_name)
      return nil unless container_name
      container_name.sub(/\A#{project_name}-/, "")
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

    def requested_container_names
      return options[:container].compact if options[:container]
      return requested_service_names.map { |name| container_name name }.compact
      container_names
    end

    def requested_service_names
      return options[:service].compact if options[:service]
      return requested_container_names(options).map { |name| service_name name }.compact
      service_names
    end
  end
end
