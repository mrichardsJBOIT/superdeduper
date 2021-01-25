require 'test_helper'

class PhotoTest < Minitest::Unit::TestCase

  def test_comparing_duplicate_photos
    puts "Getting files from #{Dir.pwd}"
    file_one_string = './test/fixtures/some_duplicates/very_small_black_dot_exact_copy.jpeg'
    file_two_string = './test/fixtures/very_small_black_dot.jpeg'

    photo_one = Superdeduper::Photo.new(File.absolute_path(file_one_string), IO.binread(file_one_string))
    photo_two = Superdeduper::Photo.new(File.absolute_path(file_two_string), IO.binread(file_two_string))

    assert(photo_one == photo_two, 'Photos should have identical content')
  end

  def test_comparing_unique_photos
    puts "Getting files from #{Dir.pwd}"
    file_one_string = './test/fixtures/some_duplicates/very_small_black_dot_exact_copy.jpeg'
    file_two_string = './test/fixtures/very_small_blue_dot.jpeg'

    photo_one = Superdeduper::Photo.new(File.absolute_path(file_one_string), IO.binread(file_one_string))
    photo_two = Superdeduper::Photo.new(File.absolute_path(file_two_string), IO.binread(file_two_string))

    assert(photo_one <=> photo_two, 'Photos should have unique content')
  end
end
