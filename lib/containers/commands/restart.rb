# frozen_string_literal: true

class Containers::CLI < Thor
  desc "restart", "Restarts container(s)"
  method_option :container, type: :array, aliases: "-c", desc: "A list of container names (space delimited)"
  method_option :service, type: :array, aliases: "-s", desc: "A list of service names (space delimited)"
  def restart(*args)
    requested_container_names.each do |container_name|
      execute_command "docker restart #{args.join " "} #{container_name}", replace_current_process: false
    end
  end
end
