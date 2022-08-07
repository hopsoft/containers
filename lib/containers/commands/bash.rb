# frozen_string_literal: true

class Containers::CLI < Thor
  desc "bash", "Starts a bash shell"
  method_option :container, type: :string, aliases: "-c", default: "shell", desc: "The short name for the container"
  def bash(*args)
    execute_command "containers exec -c #{options[:container]} bash #{args.join " "}"
  end
end
