# frozen_string_literal: true

module Containers::Configurable
  extend ActiveSupport::Concern

  DEFAULT_CONFIG = {
    "docker_dir" => ".",
    "app_dir" => ".",
    "project_name" => File.basename(Dir.pwd).parameterize
  }.freeze

  def project_name
    config["project_name"]
  end

  def docker_dir
    config["docker_dir"]
  end

  def app_dir
    config["app_dir"]
  end

  def config
    @config ||=
      if File.exist?(".containers.yml")
        YAML.load_file(".containers.yml")
      else
        DEFAULT_CONFIG
      end
  end
end
