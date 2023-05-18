# frozen_string_literal: true

require "fileutils"
require_relative "../../concerns/configurable"

class Containers::Generator::CLI < Thor
  include ::Containers::Configurable

  desc "compose", "Creates a docker-compose.yml file for the project"
  method_option :template, type: :string, aliases: "-t", desc: "The docker-compose.yml template to use (can be a local file or a URL)"
  def compose
    FileUtils.mkdir_p docker_directory
    path = File.expand_path("#{docker_directory}/docker-compose.yml")
    exists = File.exist?(path)
    original = File.read(path) if exists

    continue = if exists
      ask("#{Rainbow("docker-compose.yml already exists").red} Overwrite?", default: "n").to_s.upcase == "Y"
    else
      true
    end

    return unless continue

    FileUtils.rm_f path

    vars = {
      organization: {name: ask("What is the organization name?", default: organization_name).to_s},
      app: {
        name: ask("What is the app name?", default: app_name).to_s.parameterize,
        directory: File.expand_path(ask("What is the path to the app directory? ", default: app_directory).to_s)
      }
    }

    contents = if options[:template]
      render_external_template options[:template], vars
    else
      render_template "docker-compose.yml", vars
    end

    puts_command Rainbow("(Create #{path})").green.faint
    File.write path, contents
    puts Rainbow("docker-compose.yml created successfully").green.bright
  rescue => error
    puts Rainbow("Unexpected error! #{error.message}").red.bright
    if exists && original
      puts Rainbow("Restoring the original file.").green.faint
      File.write path, original
    end
  end
end
