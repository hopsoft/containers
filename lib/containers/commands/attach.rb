# frozen_string_literal: true

class Containers::CLI < Thor
  desc "attach", "Attaches to a running container"
  method_option :container, type: :string, aliases: "-c", required: true, desc: "The short name for the container"
  def attach(*args)
    execute_command "docker attach #{project_name}-#{options[:container]} #{args.join " "}"
  end
end
