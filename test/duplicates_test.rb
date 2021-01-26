require "test_helper"

class DuplicatesTest < Minitest::Test


  def test_image_fixtures_are_duplicates
    puts "Getting files from #{Dir.pwd}"
    file_one_string = IO.binread('./test/fixtures/some_duplicates/very_small_black_dot_exact_copy.jpeg')
    file_two_string = IO.binread('./test/fixtures/very_small_black_dot.jpeg')
    assert_equal(file_one_string, file_two_string, "Checked files #{file_one_string} equal #{file_two_string}")
  end

  def test_text_fixtures_are_duplicates
    puts "Getting files from #{Dir.pwd}"
    file_one_string = IO.binread('./test/fixtures/some_non_image_file.txt')
    file_two_string = IO.binread('./test/fixtures/some_non_image_file_copy.txt')
    assert_equal(file_one_string, file_two_string, "Checked files #{file_one_string} equal #{file_two_string}")
  end
end
