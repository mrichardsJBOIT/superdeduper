# Super De Duper

---
A command-line program in the Ruby language which finds files which have exactly the same contents and outputs any duplicates (and their locations) to standard output.  

The Ruby language was chosen as an opportunity to learn more and further my knowledge of that ecosystem and stack.

Further detailed discussions are available at the [project's github pages](https://mrichardsjboit.github.io/superdeduper/)
## Installation
Given, this is a development exercise, you will need to install using the local gem file in the projects root folder

```ruby
gem install superdeduper-0.1.0.gem
```
Or, as noted in the development section below...run `bundle exec rake install`
## Usage

    superdeduper [options]   
    -d DIRECTORY, --directory=DIRECTORY Root of folders to be traversed, e.g.'-d /home/' or '--directory=/home' the current folder is used by default.)
    -f, --filter=FILTER                 File extension filter use:'*.<ext>' example:'-f*.jpeg'
    -h, --help                          Prints this help

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

While bug reports and pull requests are welcome.....they're unlikely to be read or actioned as this is a programming exercise that won't be mainatined.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
