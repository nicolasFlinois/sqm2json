# Sqm2Json [![Gem Version](https://badge.fury.io/rb/sqm2json.svg)](https://badge.fury.io/rb/sqm2json)

This gem can convert SQM mission files from Arma3 to JSON documents. And vice versa. Missions content can be either parsed easily, and generated from standard JSON representation.  

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'sqm2json'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install sqm2json

## Usage

This library embeds a module called **Sqm2Json** and its submodule **Sqm2Json::Reverse** ;  include or extends them, then you can play with main methods:

```ruby
require 'sqm2json'

class MyClass
  include Sqm2Json,Sqm2Json::Reverse
end

mission_as_json = MyClass.new.to_json(File.read('sqm_mission_file_path'))
mission_as_sqm  = MyClass.new.to_sqm(mission_as_json)
```



## Development
After checking out the repo, you can run `bundle install` to install the dependencies. Then, you can run `bundle exec rake spec` to execute the tests and run `bundle exec rake yard` to build the documentation.
You can also run `bundle exec irb` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `lib/sqm2json/version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/arma3. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.