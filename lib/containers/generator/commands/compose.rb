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

    continue = if File.exist?(path)
      ask("#{Rainbow("docker-compose.yml already exists").red} Overwrite?", default: "Y").to_s.upcase == "Y"
    else
      true
    end

    return unless continue

    vars = {
      organization_name: ask("What is the organization name? (lowercase, dasherized)", default: organization_name).to_s,
      project_name: ask("What is the project name? (lowercase, dasherized)", default: project_name).to_s,
      app_directory: File.expand_path(ask("What is the application directory? ", default: app_directory).to_s)
    }

    contents = if options[:template]
      render_external_template options[:template], vars
    else
      render_template "docker-compose.yml", vars
    end

    puts_command Rainbow("(Create #{path})").green.faint
    File.write path, contents
    puts Rainbow("docker-compose.yml created successfully").green.bright
  end
end
