# frozen_string_literal: true

class Containers::CLI < Thor
  desc "down", "Tears down the environment defined in docker-compose.yml"
  def down(*args)
    execute_command "docker compose #{docker_compose_files.map { |f| "-f #{f}" }.join " "} down #{args.join " "}"
  end
end
