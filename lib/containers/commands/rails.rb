class Containers::CLI < Thor
  desc "rails", "Runs the Rails command"
  method_option :container, type: :string, aliases: "-c", default: "shell", desc: "The short name for the container"
  def rails(*args)
    execute_command "containers bundle -c #{options[:container]} exec rails #{args.join " "}"
  end
end
