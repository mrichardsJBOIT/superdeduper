# frozen_string_literal: true

require_relative 'photo'
require_relative 'duplicate_file_iterator'

module Superdeduper
  ##
  # Wraps photos in a collection
  class PhotosCollector
    attr_reader :all

    def initialize(root_folder = '.', filter = '*')
      @root_folder = root_folder
      @filter = filter
      @all = []
    end

    def duplicates
      # How does this scale?
      # Needs a way of separating large collections, identifying duplicates in each group
      # How then is each group brought back together?
      DuplicateFileIterator.new(@all).each
    end

    def uniques
      DuplicateFileIterator.new(@all, false).each
    end

    def display_duplicates
      puts 'The dupes....'
      duplicates.each_with_index do |e, i|
        puts "\nDuplicate No[#{i}].."
        e[1].each { |p| puts "--Exists at -> #{p.path}" }
      end
    end

    def collect
      all_files
      @all
    end

    private

    def all_files
      Dir.chdir(@root_folder)
      file_list = Dir.glob("**/#{@filter}")
      file_list.each do |file|
        next if File.directory?(file)

        begin
          unless File.directory?(file)
            photo = Photo.new(File.absolute_path(file), IO.binread(file))
            @all << photo
          end
        rescue IOError => e
          puts e.to_s
        end
      end
    end
  end
end
