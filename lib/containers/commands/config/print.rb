# frozen_string_literal: true

class Containers::CLI < Thor
  desc "config:print", "Prints the configuration for the current directory"
  def config_print(*args)
    awesome_print configuration
  end

  map "config:print" => :config_print
  map "config" => :config_print
end
