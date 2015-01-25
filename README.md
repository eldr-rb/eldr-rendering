# Eldr::Rendering [![Build Status](https://travis-ci.org/eldr-rb/eldr-rendering.svg)](https://travis-ci.org/eldr-rb/eldr-rendering) [![Code Climate](https://codeclimate.com/github/eldr-rb/eldr-rendering/badges/gpa.svg)](https://codeclimate.com/github/eldr-rb/eldr-rendering) [![Coverage Status](https://coveralls.io/repos/eldr-rb/eldr-rendering/badge.svg?branch=master)](https://coveralls.io/r/eldr-rb/eldr-rendering?branch=master) [![Dependency Status](https://gemnasium.com/eldr-rb/eldr-rendering.svg)](https://gemnasium.com/eldr-rb/eldr-rendering) [![Inline docs](https://inch-ci.org/github/eldr-rb/eldr-rendering.svg?branch=master)](http://inch-ci.org/github/eldr-rb/eldr-rendering) [![Gratipay](https://img.shields.io/gratipay/k2052.svg)](https://www.gratipay.com/k2052)

Template helpers for Eldr apps and compatible Rack apps.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'eldr-rendering'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install eldr-rendering

## Usage

To use the render helper create an Eldr::App and call it in a route's handler:

```ruby
class App < Eldr::App
  include Eldr::Rendering
  set :views_dir, File.join(__dir__, 'views')

  get '/cats' do
    render 'cats.slim'
  end
end
```

It will wrap the template up in a Rack::Response and return it.

Inside your template you can make use of the tag helpers. Eldr::Rendering currently provides just two html helpers; tag() and content_tag().

You can use tag() for one line tags like links:

```ruby
tag(:a, :data => { :remote => true, :method => 'post'})
```

And content_tag for html tags that need to be outputted with a block of content:

```ruby
content_tag(:p, :class => 'large', :id => 'star') { "Demo" }
```

Eldr::Rendering is usable in any valid Rakc  that has a configuration object that responds to `views_dir` and `engine`.  You can use it in [eldr-action](https://github.com/eldr-rb/eldr-action) or any valid Rack app.

For example:

```ruby
class App
  include Eldr::Rendering

  attr_accessor :configuration

  def initialize
    @configuration = Struct.new(:views_dir, :engine)
    @configuration.views_dir = File.join(__dir__, 'views')
    @configuratio.engine     = 'slim'
  end

  def call(env)
    render 'cats.slim'
  end
end

run App.new
```

See [examples/app.ru](https://github.com/eldr-rb/eldr-rendering/tree/master/examples/app.ru) for an example app.

## Contributing

1. Fork. it
2. Create. your feature branch (git checkout -b cat-evolver)
3. Commit. your changes (git commit -am 'Add Cat Evolution')
4. Test. your changes (always be testing)
5. Push. to the branch (git push origin cat-evolver)
6. Pull. Request. (for extra points include funny gif and or pun in comments)

To remember this you can use the easy to remember and totally not tongue-in-check initialism: FCCTPP.

I don't want any of these steps to scare you off. If you don't know how to do something or are struggle getting it to work feel free to create a pull request or issue anyway. I'll be happy to help you get your contributions up to code and into the repo!

## License

Licensed under MIT by K-2052.
