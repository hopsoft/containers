# frozen_string_literal: true

class Containers::CLI < Thor
  desc "tail", "Tails container logs"
  long_desc "Also aliased as `logs` and `log` for convenience"
  method_option :container, type: :array, aliases: "-c", desc: "A list of container names (space delimited)"
  method_option :service, type: :array, aliases: "-s", desc: "A list of service names (space delimited)"
  def tail(*args)
    args << "--since 5m" unless args.include?("--since")
    execute_command "docker compose #{docker_compose_files.map { |f| "-f #{f}" }.join " "} logs #{arguments(*args)} -f #{requested_service_names(*args).join " "}"
  end

  map "logs" => :tail
  map "log" => :tail
end
