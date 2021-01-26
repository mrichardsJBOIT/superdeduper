# frozen_string_literal: true

require_relative 'superdeduper/version'
require_relative 'superdeduper/duper_cli_parser'
require_relative 'superdeduper/photo'
require_relative 'superdeduper/photos_collector'

module Superdeduper

  # The main Super De Duper driver.
  # A command-line program in your chosen language which finds files which have exactly the same contents and
  # outputs any duplicates (and their locations) to standard output
  class Superdeduper
    def initialize(args = nil)
      @cli_parser = DuperCliParser.new(args)
    end

    def perform
      # Get options passed in
      # Collect all files in target folder or compressed file structure
      # Display the duplicates
      begin
        @cli_parser.parse
      rescue CliParsingError => e
        puts e.to_s
        exit 1
      end
      puts "Options given: #{@cli_parser.options}"
      collector = PhotosCollector.new(@cli_parser.option('directory'), @cli_parser.option('filter'))
      collector.collect
      collector.display_duplicates
    end
  end

  de_duper = Superdeduper.new(ARGV)
  de_duper.perform

end

