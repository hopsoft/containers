# frozen_string_literal: true

class Containers::CLI < Thor
  desc "yarn", "Runs the yarn command"
  method_option :container, type: :string, aliases: "-c", default: "shell", desc: "The short name for the container"
  def yarn(*args)
    execute_command "containers exec -c #{options[:container]} yarn #{args.join " "}"
  end
end
