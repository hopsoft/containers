# frozen_string_literal: true

class Containers::CLI < Thor
  desc "up", "Brings up the environment defined in docker-compose.yml"
  def up(*args)
    execute_command "docker compose up -d #{args.join " "}"
  end
end
