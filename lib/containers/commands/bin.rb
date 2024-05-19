# frozen_string_literal: true

class Containers::CLI < Thor
  desc "bin", "Runs executables in the ./bin directory"
  method_option :container, type: :string, aliases: "-c", desc: "The container name"
  method_option :service, type: :string, aliases: "-s", desc: "The service name"
  def bin(*args)
    requested_container_names(*args) do |container|
      execute_command "containers exec -c #{container} bin/#{arguments(*args)}"
    end
  end
end
