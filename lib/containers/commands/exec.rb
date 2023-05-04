# frozen_string_literal: true

class Containers::CLI < Thor
  desc "exec", "Executes a command in a container"
  method_option :container, type: :string, aliases: "-c", desc: "The container name"
  method_option :service, type: :string, aliases: "-s", default: "shell", desc: "The service name"
  def exec(*args)
    container = options[:container] || container_name(options[:service])
    execute_command "docker exec -it #{container} #{args.join " "}"
  end
end
