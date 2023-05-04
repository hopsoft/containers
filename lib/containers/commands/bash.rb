# frozen_string_literal: true

class Containers::CLI < Thor
  desc "bash", "Starts a bash shell"
  method_option :container, type: :string, aliases: "-c", desc: "The container name"
  method_option :service, type: :string, aliases: "-s", desc: "The service name"
  def bash(*args)
    container = options[:container] || container_name(options[:service])
    execute_command "containers exec -c #{container} bash #{args.join " "}"
  end
end
