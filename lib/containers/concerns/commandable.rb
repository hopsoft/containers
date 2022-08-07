# frozen_string_literal: true

module Containers::Commandable
  extend ActiveSupport::Concern

  PREFIX = "▶"

  alias_method :execute, :exec

  def puts_command(command)
    puts "#{Rainbow(PREFIX).green.faint} #{Rainbow(command).green.bright}"
  end

  def execute_command(command, replace_current_process: true)
    command = command.squish
    puts_command command
    replace_current_process ? execute(command) : puts(`#{command}`)
  end
end
