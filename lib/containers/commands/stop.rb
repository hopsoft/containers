class Containers::CLI < Thor
  desc "stop", "Stops container(s)"
  method_option :container, type: :string, aliases: "-c", desc: "The short name for the container"
  def stop(*args)
    return execute_command "docker stop #{args.join " "} #{project_name}-#{options[:container]}" if options[:container]
    container_names.each { |c| execute_command "docker stop #{args.join " "} #{c}", replace_current_process: false }
  end
end
