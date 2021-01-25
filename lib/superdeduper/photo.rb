module Superdeduper

  # Represents the location and internal data of a photo file
  class Photo
    include Comparable
    attr_accessor :path, :io_string # , :original_image_path

    def initialize(path, io_string)
      @path = path
      @io_string = io_string
    end

    # def duplicate
    #   original_image_path.nil?
    # end

    def <=>(other)
      @io_string <=> other.io_string # should this use length or size?
    end

    def ==(other)
      @io_string == other.io_string
    end
  end
end
