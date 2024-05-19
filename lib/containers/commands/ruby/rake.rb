# frozen_string_literal: true

class Containers::CLI < Thor
  desc "rake", "Runs ruby's rake command"
  method_option :container, type: :string, aliases: "-c", desc: "The container name"
  method_option :service, type: :string, aliases: "-s", desc: "The service name"
  def rake(*args)
    requested_container_names(*args) do |container|
      execute_command "containers exec -c #{container} rake #{arguments(*args)}"
    end
  end
end
