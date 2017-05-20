# PatternMatcher

Demo gem that implements wildcard pattern matching.

Matches runs of plain characters, e.g.

`PatternMatcher.match("aba", "aba") == true`

Also supports patterns with `<letter>*` for zero or more occurrences of that letter:

`PatternMatcher.match("abba", "b*ab*a") == true`

Production code is here: https://github.com/skarger/pattern_matcher/blob/master/lib/pattern_matcher.rb

Rspec tests are here: https://github.com/skarger/pattern_matcher/blob/master/spec/pattern_matcher_spec.rb

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'pattern_matcher', git: "https://github.com/skarger/pattern_matcher.git"
```

And then execute:

    $ bundle

Or install it yourself as:

    $ git clone git@github.com:skarger/pattern_matcher.git
    $ rake build
    $ gem install pkg/pattern_matcher-0.1.0.gem

## Usage
```
$ irb
irb(main):001:0> require 'pattern_matcher'
=> true
irb(main):002:0> PatternMatcher.match("aabba", "aab*a*")
=> true
irb(main):003:0> PatternMatcher.match("baabba", "aab*a*")
=> false
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

This is a demo project, but if you insist:

Bug reports and pull requests are welcome on GitHub at https://github.com/skarger/pattern_matcher.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

