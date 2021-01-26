# frozen_string_literal: true

module Superdeduper

  # Represents the location and internal data of a photo file
  class Photo
    include Comparable
    attr_reader :path, :io_string

    def initialize(path, io_string)
      @path = path
      @io_string = io_string
    end

    def <=>(other)
      @io_string <=> other.io_string # should this use length or size?
    end

    def ==(other)
      @io_string == other.io_string
    end

    def to_s
      @path
    end

    def aggregator
      @io_string
    end
  end
end
