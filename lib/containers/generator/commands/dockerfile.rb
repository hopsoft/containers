# frozen_string_literal: true

require "fileutils"
require_relative "../../concerns/configurable"

class Containers::Generator::CLI < Thor
  include ::Containers::Configurable

  desc "dockerfile", "Creates a Dockerfile for the project"
  method_option :template, type: :string, aliases: "-t", desc: "The Dockerfile template to use (can be a local file or a URL)"
  def dockerfile
    FileUtils.mkdir_p docker_directory
    path = File.expand_path("#{docker_directory}/Dockerfile")

    continue = if File.exist?(path)
      ask("#{Rainbow("Dockerfile already exists").red} Overwrite?", default: "Y").to_s.upcase == "Y"
    else
      true
    end

    return unless continue

    ruby_version = ask("What Ruby version does this project use?", default: "3.1.2").to_s
    vars = {ruby_version: ruby_version}

    contents = if options[:template]
      render_external_template options[:template], vars
    else
      render_template "Dockerfile", vars
    end

    puts_command Rainbow("(Create #{path})").green.faint
    File.write path, contents
    puts Rainbow("Dockerfile created successfully").green.bright
  end
end
