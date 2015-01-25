require 'eldr'
require 'slim'
require_relative '../lib/eldr/rendering'

class App < Eldr::App
  include Eldr::Rendering
  set :views_dir, File.join(__dir__, 'views')

  get '/cats' do
    render 'cats.slim'
  end

  get '/no-template' do
    render 'template.slim'
  end
end

run App
