# frozen_string_literal: true

module Containers::Configurable
  extend ActiveSupport::Concern

  def self.gitname
    email = begin
      `git config --get user.email`.strip
    rescue
      nil
    end
    email&.split("@")&.first || "example"
  end

  DEFAULT_CONFIGURATION = {
    "organization" => {
      "name" => gitname
    },
    "app" => {
      "name" => File.basename(Dir.pwd).parameterize,
      "directory" => "."
    },
    "docker" => {
      "directory" => ".",
      "default_service" => nil,
      "compose_files" => ["docker-compose.yml"]
    }
  }.freeze

  def organization_name
    configuration["organization"]["name"]
  end

  def app_name
    configuration["app"]["name"]
  end

  def app_directory
    configuration["app"]["directory"]
  end

  def docker_directory
    configuration["docker"]["directory"]
  end

  def docker_default_service
    configuration["docker"]["default_service"]
  end

  def docker_compose_files
    configuration["docker"]["compose_files"]
  end

  def configuration
    @configuration ||=
      if File.exist?(".containers.yml")
        YAML.load_file(".containers.yml")
      else
        DEFAULT_CONFIGURATION
      end
  end
end
