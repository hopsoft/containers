# frozen_string_literal: true

class Containers::CLI < Thor
  desc "inspect", "Inspects a container"
  method_option :container, type: :string, aliases: "-c", required: true, desc: "The short name for the container"
  def inspect(*args)
    execute_command "docker inspect #{args.join " "} #{project_name}-#{options[:container]}"
  end
end
