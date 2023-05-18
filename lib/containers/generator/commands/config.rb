# frozen_string_literal: true

require_relative "../../concerns/configurable"

class Containers::Generator::CLI < Thor
  include ::Containers::Configurable

  desc "config", "Creates a .containers.yml config file for the project"
  def config
    path = File.expand_path(".containers.yml")
    exists = File.exist?(path)
    original = File.read(path) if exists

    continue = if exists
      ask("#{Rainbow(".containers.yml already exists").red} Overwrite?", default: "n").to_s.upcase == "Y"
    else
      true
    end

    return unless continue

    FileUtils.rm_f path

    vars = {
      organization_name: ask("What is the organization name?", default: organization_name).to_s.parameterize,
      app_name: ask("What is the app name?", default: app_name).to_s.parameterize,
      app_directory: File.expand_path(ask("What is the path to the app directory? ", default: app_directory).to_s),
      docker: {
        directory: File.expand_path(ask("What is the path to the Docker directory? ", default: docker_directory).to_s),
        default_service: ask("What is the default Docker service?", default: docker_default_service).to_s,
        compose_files: docker_compose_files
      }
    }

    File.write path, render_template("containers.yml", vars)
  rescue => error
    puts Rainbow("Unexpected error! #{error.message}").red.bright
    if exists && original
      puts Rainbow("Restoring the original file.").green.faint
      File.write path, original
    end
  end
end
