# frozen_string_literal: true

class Containers::CLI < Thor
  desc "restart", "Restarts container(s)"
  method_option :container, type: :array, aliases: "-c", desc: "A list of container names (space delimited)"
  method_option :service, type: :array, aliases: "-s", desc: "A list of service names (space delimited)"
  def restart(*args)
    requested_container_names(*args) do |container|
      execute_command "docker restart #{arguments(*args)} #{container}", replace_current_process: false
    end
  end
end
