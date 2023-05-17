# frozen_string_literal: true

class Containers::CLI < Thor
  desc "bin", "Runs executables in the ./bin directory"
  method_option :container, type: :string, aliases: "-c", desc: "The container name"
  method_option :service, type: :string, aliases: "-s", desc: "The service name"
  def bin(*args)
    container = options[:container] || container_name(options[:service])
    execute_command "containers exec -c #{container} bin/#{args.join " "}"
  end
end
