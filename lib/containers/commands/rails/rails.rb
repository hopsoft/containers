# frozen_string_literal: true

class Containers::CLI < Thor
  desc "rails", "Runs the Rails command"
  method_option :container, type: :string, aliases: "-c", desc: "The container name"
  method_option :service, type: :string, aliases: "-s", desc: "The service name"
  def rails(*args)
    container = options[:container] || container_name(options[:service])
    execute_command "containers bundle -c #{container} exec rails #{args.join " "}"
  end
end
