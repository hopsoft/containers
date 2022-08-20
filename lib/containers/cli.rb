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

    def container_names
      `containers list -f`.split("\n")
    end
  end
end
