# frozen_string_literal: true

class Containers::CLI < Thor
  desc "yarn", "Runs the yarn command"
  method_option :container, type: :string, aliases: "-c", desc: "The container name"
  method_option :service, type: :string, aliases: "-s", default: "shell", desc: "The service name"
  def yarn(*args)
    container = options[:container] || container_name(options[:service])
    execute_command "containers exec -c #{container} yarn #{args.join " "}"
  end
end
