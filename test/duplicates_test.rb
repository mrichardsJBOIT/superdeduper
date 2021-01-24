require "test_helper"

class DuplicatesTest < Minitest::Test
  def setup
    # Create and save two identical files
    # @file_one = 'artefacts/very_small_black_dot.jpeg'
    # @file_one_copy = 'artefacts/very_small_black_dot_exact_copy.jpeg'
    # @file_two = 'artefacts/very_small_blue_dot.jpeg'
    # @deduper = Superdeduper::Superdeduper.new
  end

  def teardown
    # Delete the files
  end

  def test_performing_positve
    skip "Not done yet..."
    assert(@deduper.perform.start_with?('performing'), "We are performing")
  end
end