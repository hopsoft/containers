# frozen_string_literal: true

require "pry-byebug"
require "thor"
require "rainbow"
require "active_support/all"
require_relative "concerns/commandable"
require_relative "subcommands/generate"

module Containers
  class CLI < Thor
    include Commandable

    Dir["commands/**/*.rb", base: __dir__].each { |f| require_relative f }

    desc "generate", "Commands used to generate files for the project"
    subcommand "generate", Generate

    protected

    def project_name
      File.basename(Dir.pwd).parameterize
    end

    def container_names
      `containers list -f`.split("\n")
    end
  end
end
