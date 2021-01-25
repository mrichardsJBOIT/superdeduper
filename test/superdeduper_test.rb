require "test_helper"

class SuperdeduperTest < Minitest::Test
  include Aruba::Api

  def setup
    setup_aruba
  end

  def test_that_it_has_a_version_number
    refute_nil ::Superdeduper::VERSION
  end

  def test_if_superdeduper_runs
    run_command("superdeduper")
    last_command = last_command_started.command
    assert_equal(last_command, 'superdeduper', 'superdeduper Starts ')
  end

end
