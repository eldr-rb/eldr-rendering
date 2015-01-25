require 'tilt'

require_relative 'rendering/output_helpers'
require_relative 'rendering/tag_helpers'

module Eldr
  module Rendering
    class NotFound < StandardError
      def call(env)
        Rack::Response.new message, 404
      end
    end

    def render(path, resp_code = 200)
      Rack::Response.new Tilt.new(find_template(path)).render(self), resp_code
    end

    def find_template(path)
      configuration.engine ||= 'slim'
      raise StandardError, 'Eldr::Rendering requires you to set config.views_dir' unless configuration.views_dir
      template = Pathname.new(File.join(configuration.views_dir, path))
      template = Pathname.new(template.to_s + '.' + configuration.engine) if template.extname.blank?
      raise NotFound, 'Template Not Found' unless File.exist? template
      template.to_s
    end

    def self.included(klass)
      klass.include Tags
      klass.include Output
    end
  end
end
