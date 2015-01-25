require 'eldr'
require 'slim'
require_relative '../lib/eldr/rendering'

require 'rack/test'
require 'rack'
require 'rspec-html-matchers'

module GlobalConfig
  extend RSpec::SharedContext
  let(:rt) do
    Rack::Test::Session.new(app)
  end

  let(:app) do
    App.new()
  end
end

RSpec.configure do |config|
  config.include Rack::Test::Methods
  config.include GlobalConfig
  config.include Eldr::Rendering::Output
  config.include Eldr::Rendering::Tags
end
