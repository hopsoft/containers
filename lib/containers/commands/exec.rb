# frozen_string_literal: true

class Containers::CLI < Thor
  desc "exec", "Executes a command in a container"
  long_desc "Also aliased as `x` for convenience"
  method_option :container, type: :string, aliases: "-c", desc: "The container name"
  method_option :service, type: :string, aliases: "-s", desc: "The service name"
  def exec(*args)
    requested_container_names(*args) do |container|
      execute_command "docker exec -it #{container} #{arguments(*args)}"
    end
  end

  map "x" => :exec
end
