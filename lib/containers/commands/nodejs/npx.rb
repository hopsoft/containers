# frozen_string_literal: true

class Containers::CLI < Thor
  desc "npx", "Runs the npx command"
  method_option :container, type: :string, aliases: "-c", desc: "The container name"
  method_option :service, type: :string, aliases: "-s", desc: "The service name"
  def npx(*args)
    container = options[:container] || container_name(options[:service])
    execute_command "containers exec -c #{container} npx #{args.join " "}"
  end
end
