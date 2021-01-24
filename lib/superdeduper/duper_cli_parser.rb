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
          raise OptionParser::InvalidArgument, "DIRECTORY [#{dir}] does not exist" unless Dir.exist?(dir.strip)

          @options[:directory] = dir
        end
      end
      option_parser.parse!(args) if args
    end

    private

    def defaults
      @options = {}
      @options[:directory] = Dir.pwd.to_s.strip
    end

  end
end
