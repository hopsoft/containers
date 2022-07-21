# frozen_string_literal: true

require "thor"
require "rainbow"
require_relative "./generator"

module Containers
  class CLI < Thor
    alias_method :execute, :exec

    desc "generate", "Commands used to generate files for the project"
    subcommand "generate", Generator

    desc "up", "Brings up the environment defined in docker-compose.yml"
    def up(*args)
      execute_command "docker compose up -d #{args.join " "}"
    end

    desc "down", "Tears down the environment defined in docker-compose.yml"
    def down(*args)
      execute_command "docker compose down #{args.join " "}"
    end

    desc "list", "Lists all containers for this project"
    method_option :type, type: :string, enum: %w[short full detailed], aliases: "-t", default: "short", desc: "The type of container list to display"
    def list(*args)
      return execute_command "docker ps -a | grep #{project_name}" if options[:type] == "detailed"
      list = `containers list -t detailed`.split("\n")
      return puts list.map { |item| item.split(" ").last }.sort.join("\n") if options[:type] == "full"
      puts list.map { |item| item.split(" ").last.sub(/\A#{project_name}-/, "") }.sort.join("\n")
    end

    desc "inspect", "Inspects a container"
    method_option :container, type: :string, aliases: "-c", required: true, desc: "The short name for the container"
    def inspect(*args)
      execute_command "docker inspect #{args.join " "} #{project_name}-#{options[:container]}"
    end

    desc "attach", "Attaches to a running container"
    method_option :container, type: :string, aliases: "-c", required: true, desc: "The short name for the container"
    def attach(*args)
      execute_command "docker attach #{project_name}-#{options[:container]} #{args.join " "}"
    end

    desc "exec", "Executes a command in a container"
    method_option :container, type: :string, aliases: "-c", default: "shell", desc: "The short name for the container"
    def exec(*args)
      execute_command "docker exec -it #{project_name}-#{options[:container]} #{args.join " "}"
    end

    desc "tail", "Tails a container's logs"
    method_option :container, type: :string, aliases: "-c", required: true, desc: "The short name for the container"
    def tail(*args)
      execute_command "docker logs -f #{args.join " "} #{project_name}-#{options[:container]}"
    end

    desc "start", "Starts container(s)"
    method_option :container, type: :string, aliases: "-c", desc: "The short name for the container"
    def start(*args)
      return execute_command "docker start #{args.join " "} #{project_name}-#{options[:container]}" if options[:container]
      containers = `containers list -t full`.split("\n")
      containers.each { |c| execute_command "docker start #{args.join " "} #{c}" }
    end

    desc "stop", "Stops container(s)"
    method_option :container, type: :string, aliases: "-c", desc: "The short name for the container"
    def stop(*args)
      return execute_command "docker stop #{args.join " "} #{project_name}-#{options[:container]}" if options[:container]
      containers = `containers list -t full`.split("\n")
      containers.each { |c| execute_command "docker stop #{args.join " "} #{c}" }
    end

    desc "restart", "Restarts container(s)"
    method_option :container, type: :string, aliases: "-c", desc: "The short name for the container"
    def restart(*args)
      return execute_command "docker restart #{args.join " "} #{project_name}-#{options[:container]}" if options[:container]
      containers = `containers list -t full`.split("\n")
      containers.each { |c| execute_command "docker restart #{args.join " "} #{c}" }
    end

    private

    def project_name
      squish(File.basename(Dir.pwd)).gsub(/\s|_/, "-")
    end

    def squish(string)
      string.gsub(/\s+/, " ").strip
    end

    def execute_command(command)
      command = squish(command)
      puts "\n#{Rainbow("→").faint} #{Rainbow(command).cyan}\n\n"
      execute command
    end
  end
end
