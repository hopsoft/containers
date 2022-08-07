require "erb"

module Containers::Generator
  class CLI < Thor
    include Containers::Commandable
    Dir["commands/**/*.rb", base: __dir__].each { |f| require_relative f }

    protected

    def template_path(template_name)
      Pathname.new(__dir__).join "templates/#{template_name}.erb"
    end

    def raw_template(template_name)
      File.read template_path(template_name)
    end

    def erb_template(template_name)
      ERB.new raw_template(template_name)
    end

    def render(template_name, vars = {})
      view = Struct.new(*vars.keys).new(*vars.values).instance_eval { binding }
      erb_template(template_name).result view
    end
  end
end
