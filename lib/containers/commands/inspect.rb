# frozen_string_literal: true

class Containers::CLI < Thor
  desc "inspect", "Inspects a container"
  method_option :container, type: :string, aliases: "-c", desc: "The container name"
  method_option :service, type: :string, aliases: "-s", desc: "The service name"
  def inspect(*args)
    container = options[:container] || container_name(options[:service])
    execute_command "docker inspect #{args.join " "} #{container}"
  end
end
