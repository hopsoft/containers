# frozen_string_literal: true

class Containers::CLI < Thor
  desc "rails", "Runs the Rails command"
  method_option :container, type: :string, aliases: "-c", desc: "The container name"
  method_option :service, type: :string, aliases: "-s", desc: "The service name"
  def rails(*args)
    requested_container_names(*args) do |container|
      execute_command "containers bundle -c #{container} exec rails #{arguments(*args)}"
    end
  end
end
