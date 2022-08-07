# frozen_string_literal: true

class Containers::CLI < Thor
  desc "tail", "Tails container logs"
  method_option :container, type: :array, aliases: "-c", required: true, desc: "The short name for the container (also supports a list of names)"
  def tail(*args)
    args << "--since 5m" unless args.include?("--since")
    execute_command "docker compose logs #{args.join " "} -f #{options[:container].join " "}"
  end
end
