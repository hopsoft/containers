# frozen_string_literal: true

require "thor"
require "rainbow"
require_relative "./generator"

module Containers
  class CLI < Thor
    COMMAND_PREFIX = "▶"

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
    method_option :detailed, type: :boolean, aliases: "-d", desc: "List detailed container information"
    method_option :service, type: :boolean, aliases: "-s", desc: "List container service names"
    def list(*args)
      return execute_command "docker ps -a | grep #{project_name}" if options[:detailed]

      if options[:service]
        command = "containers list -f"
        puts_command "#{command} | #{Rainbow("(strip project name)").green.faint}"
        list = `#{command}`.split("\n").reject { |item| item.strip == "" || item.include?(COMMAND_PREFIX) }
        puts list.map { |item| item.gsub(/\A#{project_name}-|\s/, "") }.sort.join("\n")
        return
      end

      command = "containers list -d"
      puts_command "#{command} | #{Rainbow("(strip docker details)").green.faint}"
      list = `#{command}`.split("\n").reject { |item| item.strip == "" || item.include?(COMMAND_PREFIX) }
      puts list.map { |item| item.split(" ").last.strip }.sort.join("\n")
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
      options[:container] = "shell" if options[:container].to_s.strip == ""
      execute_command "docker exec -it #{project_name}-#{options[:container]} #{args.join " "}"
    end

    desc "tail", "Tails container logs"
    method_option :container, type: :array, aliases: "-c", required: true, desc: "The short name for the container (also supports a list of names)"
    def tail(*args)
      args << "--since 5m" unless args.include?("--since")
      execute_command "docker compose logs #{args.join " "} -f #{options[:container].join " "}"
    end

    desc "start", "Starts container(s)"
    method_option :container, type: :string, aliases: "-c", desc: "The short name for the container"
    def start(*args)
      return execute_command "docker start #{args.join " "} #{project_name}-#{options[:container]}" if options[:container]
      container_names.each { |c| execute_command "docker start #{args.join " "} #{c}", replace_current_process: false }
    end

    desc "stop", "Stops container(s)"
    method_option :container, type: :string, aliases: "-c", desc: "The short name for the container"
    def stop(*args)
      return execute_command "docker stop #{args.join " "} #{project_name}-#{options[:container]}" if options[:container]
      container_names.each { |c| execute_command "docker stop #{args.join " "} #{c}", replace_current_process: false }
    end

    desc "restart", "Restarts container(s)"
    method_option :container, type: :array, aliases: "-c", desc: "A list of container short names"
    def restart(*args)
      containers = options[:container] || container_names
      containers.each { |c| execute_command "docker restart #{args.join " "} #{c}", replace_current_process: false }
    end

    desc "bash", "Starts a bash shell"
    method_option :container, type: :string, aliases: "-c", default: "shell", desc: "The short name for the container"
    def bash(*args)
      execute_command "containers exec -c #{options[:container]} bash #{args.join " "}"
    end

    desc "bundle", "Runs the bundle command"
    method_option :container, type: :string, aliases: "-c", default: "shell", desc: "The short name for the container"
    def bundle(*args)
      execute_command "containers exec -c #{options[:container]} bundle #{args.join " "}"
    end

    desc "yarn", "Runs the yarn command"
    method_option :container, type: :string, aliases: "-c", default: "shell", desc: "The short name for the container"
    def yarn(*args)
      execute_command "containers exec -c #{options[:container]} yarn #{args.join " "}"
    end

    desc "rails", "Runs the Rails command"
    method_option :container, type: :string, aliases: "-c", default: "shell", desc: "The short name for the container"
    def rails(*args)
      execute_command "containers bundle -c #{options[:container]} exec rails #{args.join " "}"
    end

    private

    def container_names
      `containers list -f`.split("\n")
    end

    def project_name
      squish(File.basename(Dir.pwd)).gsub(/\s|_/, "-")
    end

    def squish(string)
      string.gsub(/\s+/, " ").strip
    end

    def execute_command(command, replace_current_process: true)
      command = squish(command)
      puts_command command
      replace_current_process ? execute(command) : puts(`#{command}`)
    end

    def puts_command(command)
      puts "#{Rainbow(COMMAND_PREFIX).green.faint} #{Rainbow(command).green.bright}"
    end
  end
end
