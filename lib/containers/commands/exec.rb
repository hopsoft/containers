# frozen_string_literal: true

class Containers::CLI < Thor
  desc "exec", "Executes a command in a container"
  method_option :container, type: :string, aliases: "-c", default: "shell", desc: "The short name for the container"
  def exec(*args)
    options[:container] = "shell" if options[:container].to_s.strip == ""
    execute_command "docker exec -it #{project_name}-#{options[:container]} #{args.join " "}"
  end
end
