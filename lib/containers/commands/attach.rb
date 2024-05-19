# frozen_string_literal: true

class Containers::CLI < Thor
  desc "attach", "Attaches to a running container"
  method_option :container, type: :string, aliases: "-c", desc: "The container name"
  method_option :service, type: :string, aliases: "-s", desc: "The service name"
  def attach(*args)
    requested_container_names(*args) do |container|
      execute_command "docker attach #{container} #{arguments(*args)}"
    end
  end
end
