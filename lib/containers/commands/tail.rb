# frozen_string_literal: true

class Containers::CLI < Thor
  desc "tail", "Tails container logs"
  method_option :container, type: :array, aliases: "-c", desc: "A list of container names (space delimited)"
  method_option :service, type: :array, aliases: "-s", desc: "A list of service names (space delimited)"
  def tail(*args)
    args << "--since 5m" unless args.include?("--since")
    execute_command "docker compose #{docker_compose_files.map { |f| "-f #{f}" }.join " "} logs #{args.join " "} -f #{requested_service_names.join " "}"
  end
end
