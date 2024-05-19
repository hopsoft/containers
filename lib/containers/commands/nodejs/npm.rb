# frozen_string_literal: true

class Containers::CLI < Thor
  desc "npm", "Runs the npm command"
  method_option :container, type: :string, aliases: "-c", desc: "The container name"
  method_option :service, type: :string, aliases: "-s", desc: "The service name"
  def npm(*args)
    requested_container_names(*args) do |container|
      execute_command "containers exec -c #{container} npm #{arguments(*args)}"
    end
  end
end
