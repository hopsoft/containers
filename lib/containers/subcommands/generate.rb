require "erb"

class Containers::Generate < Thor
  include Containers::Commandable
  Dir["generate/commands/**/*.rb", base: __dir__].each { |f| require_relative f }

  protected

  def template_path(template_name)
    Pathname.new(__dir__).join "generate/templates/#{template_name}.erb"
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
