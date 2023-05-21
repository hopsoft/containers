# frozen_string_literal: true

class Containers::CLI < Thor
  desc "exec", "Executes a command in a container"
  long_desc "Also aliased as `x` for convenience"
  method_option :container, type: :string, aliases: "-c", desc: "The container name"
  method_option :service, type: :string, aliases: "-s", desc: "The service name"
  def exec(*args)
    container = options[:container] || container_name(options[:service])
    execute_command "docker exec -it #{container} #{args.join " "}"
  end

  map "x" => :exec
end
