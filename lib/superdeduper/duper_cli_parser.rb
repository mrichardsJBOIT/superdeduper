require 'optparse'

module Superdeduper

  class DuperCliParser
    attr_reader :options

    def initialize(args = nil)
      defaults
      @args = args
    end

    def parse(args = nil)
      args ||= @args
      option_parser = OptionParser.new do |opts|
        opts.banner = 'List image duplicates. Usage: superdeduper [options]'
        opts.on('-d DIRECTORY', '--directory=DIRECTORY', 'Root of folders to be traversed') do |dir|
          raise OptionParser::InvalidArgument, "DIRECTORY [#{dir}] does not exist, current director [#{Dir.pwd}]" unless Dir.exist?(dir.strip)

          @options[:directory] = dir
        end
        opts.on('-f FILTER', '--filter=FILTER', "File extension filter use:'*.<extension>' example:'-f *.jpeg'") do |filter|
          if filter.start_with? == '*.' && !filter[2..-1].match?(/[[:punct:]]|\s/)
            raise OptionParser::InvalidArgument, "FILTER [#{filter}] has non alpha numeric content"
          end

          @options[:filter] = filter
        end
        opts.on('-h', '--help', 'Prints this help') do
          puts opts
          # exit
        end
      end
      begin
        option_parser.parse!(args) if args
      rescue OptionParser::ParseError => e # Catches all child exception types and wraps in it's exception
        puts option_parser
        raise CliParsingError.new(e.to_s, e.reason)
      end

    end

    private

    def defaults
      @options = {}
      @options[:directory] = Dir.pwd.to_s.strip
      @options[:filter] = '*'
    end

  end

  class CliParsingError < StandardError
    attr_reader :action

    def initialize(msg = 'This is a CLI parsing error', action)
      super(msg)
      @action = action
    end
  end
end
