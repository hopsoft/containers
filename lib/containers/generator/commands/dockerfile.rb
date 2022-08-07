class Containers::Generator::CLI < Thor
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

    puts_command Rainbow("(Create #{path})").green.faint
    File.write path, render("Dockerfile", ruby_version: ruby_version)
    puts Rainbow("Dockerfile created successfully").green.bright
  end
end
