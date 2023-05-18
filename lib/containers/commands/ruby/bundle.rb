# frozen_string_literal: true

class Containers::CLI < Thor
  desc "bundle", "Runs the bundle command"
  method_option :container, type: :string, aliases: "-c", desc: "The container name"
  method_option :service, type: :string, aliases: "-s", desc: "The service name"
  def bundle(*args)
    container = options[:container] || container_name(options[:service])
    execute_command "containers exec -c #{container} bundle #{args.join " "}"
  end
end
