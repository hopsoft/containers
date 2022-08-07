class Containers::CLI < Thor
  desc "bundle", "Runs the bundle command"
  method_option :container, type: :string, aliases: "-c", default: "shell", desc: "The short name for the container"
  def bundle(*args)
    execute_command "containers exec -c #{options[:container]} bundle #{args.join " "}"
  end
end
