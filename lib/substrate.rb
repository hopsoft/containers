# frozen_string_literal: true

require "thor"
require "ruby_jard"
require_relative "substrate/version"

module Substrate
  class Error < StandardError; end

  class CLI < Thor
    def self.exit_on_failure?
      true
    end

    alias_method :kernel_exec, :exec

    desc "up", "Bring up the local environment defined in docker-compose.yml"
    def up(*args)
      execute_command "docker compose up -d #{args.join " "}"
    end

    desc "down", "Tear down the local environment defined in docker-compose.yml"
    def down(*args)
      execute_command "docker compose down #{args.join " "}"
    end

    desc "exec", "Execute a command in one of the containers defined in docker-compose.yml (defaults to the shell container)"
    def exec(*args)
      container = args.shift(2).last if args.first == "in"
      container ||= "shell"
      execute_command "docker exec -it #{project_name}-#{container} #{args.join " "}"
    end

    desc "tail", "Tails a container in the local environment"
    def tail(*args)
      container = args.shift
      execute_command "docker logs -f #{args.join " "} #{project_name}-#{container}"
    end

    desc "list", "Lists all running containers in the local environment"
    def list(*args)
      execute_command "docker ps | grep #{project_name}"
    end

    private

    def project_name
      File.basename Dir.pwd
    end

    def execute_command(command)
      puts command
      kernel_exec command
    end
  end
end
