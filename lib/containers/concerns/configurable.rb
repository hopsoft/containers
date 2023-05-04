# frozen_string_literal: true

module Containers::Configurable
  extend ActiveSupport::Concern

  DEFAULT_CONFIGURATION = {
    "organization_name" => "example-organization",
    "project_name" => File.basename(Dir.pwd).parameterize,
    "app_directory" => ".",
    "docker_directory" => ".",
    "default_service" => nil
  }.freeze

  def organization_name
    configuration["organization_name"]
  end

  def project_name
    configuration["project_name"]
  end

  def app_directory
    configuration["app_directory"]
  end

  def docker_directory
    configuration["docker_directory"]
  end

  def default_service
    configuration["default_service"]
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
