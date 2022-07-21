# frozen_string_literal: true

require "erb"

class Generator < Thor
  desc "dockerfile", "Creates a Dockerfile for the project"
  def dockerfile
    path = File.expand_path("Dockerfile")

    continue = if File.exist?(path)
      ask("#{Rainbow("Dockerfile already exists").red} Overwrite?", default: "Y").to_s.upcase == "Y"
    else
      true
    end

    return unless continue

    ruby_version = ask("What Ruby version does this project use?", default: "3.1.2").to_s
    File.write path, render("Dockerfile", ruby_version: ruby_version)
  end

  desc "docker_compose", "Creates a docker-compose.yml file for the project"
  def docker_compose
  end

  private

  def root_path
    File.expand_path(File.join(__dir__, "..", ".."))
  end

  def template(name)
    ERB.new(File.read(File.join(root_path, "lib/containers/templates/#{name}.erb")))
  end

  def render(template_name, vars = {})
    view = Struct.new(*vars.keys).new(*vars.values).instance_eval { binding }
    template(template_name).result view
  end
end
