# frozen_string_literal: true

require 'optparse'

module Superdeduper

  # Encapsulates Ruby's OptionParser for this specific application
  class DuperCliParser

    def initialize(args = nil)
      defaults
      @args = args
    end

    def parse(args = nil)
      args ||= @args
      option_parser = OptionParser.new do |opts|
        opts.banner = 'List image duplicates. Usage: superdeduper [options]'
        opts.on('-d DIRECTORY', '--directory=DIRECTORY', 'Root of folders to be traversed') do |dir|
          unless Dir.exist?(dir.strip)
            raise OptionParser::InvalidArgument, [additional: "DIRECTORY [#{dir}] does not exist, current director [#{Dir.pwd}]"]
          end

          @options[:directory] = dir
        end
        opts.on('-f', '--filter=FILTER', "File extension filter use:'*.<ext>' example:'-f*.jpeg'") do |f|
          unless f.to_s.start_with?('*.')
            raise OptionParser::InvalidArgument, [additional: "FILTER [#{f}] has incorrect prefix"]
          end

          if f.to_s[2..-1].match?(/[[:punct:]]/)
            unless f.to_s.start_with?('*.*')
              raise OptionParser::InvalidArgument, [additional: "FILTER [#{f}] has punctuation"]
            end
          end
          if f.to_s[2..-1].match?(/[[:cntrl:]]/)
            raise OptionParser::InvalidArgument, [additional: "FILTER [#{f}] has control characters"]
          end

          @options[:filter] = f.to_s
        end
        opts.on('-h', '--help', 'Prints this help') do
          puts opts
          exit
        end
      end
      begin
        option_parser.parse!(args) if args
      rescue OptionParser::InvalidOption, OptionParser::InvalidArgument => e # Catches all child exception types and wraps in it's exception
        puts "Please Check Options #{option_parser} "
        puts e.to_s
        puts e.message
        raise CliParsingError.new(e.to_s, e.reason)
      end

    end

    def options
      @options.inspect
    end

    def option(option = nil)
      @options[option.to_sym] if option
    end

    private

    def defaults
      @options = {}
      @options[:directory] = Dir.pwd.to_s.strip
      @options[:filter] = '*'
    end

  end

  class CliParsingError < StandardError
    attr_reader :extra

    def initialize(msg = 'This is a CLI parsing error', extra = nil)
      super(msg)
      @extra = extra
    end
  end
end
