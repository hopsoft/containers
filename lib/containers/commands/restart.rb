class Containers::CLI < Thor
  desc "restart", "Restarts container(s)"
  method_option :container, type: :array, aliases: "-c", desc: "A list of container short names"
  def restart(*args)
    containers = options[:container] || container_names
    containers.each { |c| execute_command "docker restart #{args.join " "} #{c}", replace_current_process: false }
  end
end
