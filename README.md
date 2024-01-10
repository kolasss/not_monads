# NotMonads

Simple copy of [dry-monads](https://github.com/dry-rb/dry-monads) do monads, it implements only mixin for your service object and Success/Failure result object.

## Installation

Install the gem and add to the application's Gemfile by executing:

    $ bundle add not_monads

or add to Gemfile

    gem 'not_monads'

If bundler is not being used to manage dependencies, install the gem by executing:

    $ gem install not_monads

## Usage

Add module to your class with prepend:

```
class CreateUser
    prepend NotMonads::Do[:call]

    def call(params)
      do_something validate(params)
      user = do_something save(params)
      Success(user)
    end

    private

    def validate(params)
      Success() || Failure(:error)
    end

    def save(params)
      Success(user) || Failure(errors)
    end
  end
end
```

Prepend with a module call with array of method names in square brackets. (`prepend NotMonads::Do[:call, :step1, :step3]`) Use method `do_something` to verify result, just like dry-monads with `yield` (`do_something` is a temporary method name, idk how to name it better yet)


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
