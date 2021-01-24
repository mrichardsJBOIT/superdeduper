require_relative 'superdeduper/version'
require_relative 'superdeduper/duper_cli_parser'

module Superdeduper
  class Error < StandardError; end

  # The main Super De Duper driver.
  # A command-line program in your chosen language which finds files which have exactly the same contents and
  # outputs any duplicates (and their locations) to standard output
  class Superdeduper
    def initialize(args = nil)
      puts args
      @time_created = Time.now.inspect
    end

    def perform
      "performing at #{Time.now.inspect}"
    end
  end
  puts "Something #{Time.now.inspect}"
  puts "We received #{ARGV}"
  puts 'very_small_black_dot_exact_copy.jpeg'
  puts 'very_small_black_dot.jpeg'
end

