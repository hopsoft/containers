# frozen_string_literal: true

class Containers::CLI < Thor
  desc "start", "Starts container(s)"
  method_option :container, type: :string, aliases: "-c", desc: "The short name for the container"
  def start(*args)
    return execute_command "docker start #{args.join " "} #{project_name}-#{options[:container]}" if options[:container]
    container_names.each { |c| execute_command "docker start #{args.join " "} #{c}", replace_current_process: false }
  end
end
