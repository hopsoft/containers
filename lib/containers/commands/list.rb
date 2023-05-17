# frozen_string_literal: true

class Containers::CLI < Thor
  desc "list", "Lists all containers for this project"
  method_option :detailed, type: :boolean, aliases: "-d", desc: "List detailed container information"
  method_option :service, type: :boolean, aliases: "-s", desc: "List container service names"
  def list(*args)
    return execute_command "docker ps -a | grep #{app_name}" if options[:detailed]

    if options[:service]
      command = "containers list"
      puts_command "#{command} | #{Rainbow("(strip app_name)").green.faint}"
      list = `#{command}`.split("\n").reject { |item| item.strip == "" || item.include?(PREFIX) }
      puts list.map { |item| item.gsub(/\A#{app_name}-|\s/, "") }.sort.join("\n")
      return
    end

    command = "containers list -d"
    puts_command "#{command} | #{Rainbow("(strip docker details)").green.faint}"
    list = `#{command}`.split("\n").reject { |item| item.strip == "" || item.include?(PREFIX) }
    puts list.map { |item| item.split(" ").last.strip }.sort.join("\n")
  end
end
