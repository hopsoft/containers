# frozen_string_literal: true

require_relative "../../concerns/configurable"

class Containers::Generator::CLI < Thor
  include ::Containers::Configurable

  desc "config", "Creates a .containers.yml config file for the project"
  def config
    path = File.expand_path(".containers.yml")

    continue = if File.exist?(path)
      ask("#{Rainbow(".containers.yml already exists").red} Overwrite?", default: "Y").to_s.upcase == "Y"
    else
      true
    end

    return unless continue

    vars = {
      organization_name: ask("What is the organization name?", default: organization_name).to_s.parameterize,
      project_name: ask("What is the project name?", default: project_name).to_s.parameterize,
      app_directory: File.expand_path(ask("What is the application directory? ", default: app_directory).to_s),
      docker_directory: File.expand_path(ask("What is the docker directory? ", default: docker_directory).to_s),
      default_service: ask("What is the default service? (web, ...)", default: default_service).to_s
    }

    File.write path, render_template("containers.yml", vars)
  end
end
