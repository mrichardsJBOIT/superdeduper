require 'test_helper'

describe 'Deduper', type: :aruba do
  include Aruba::Api
  before do
    setup_aruba
    run_command("superdeduper #{args}")
  end

  let (:args) { '-d ./fixtures' }
  it 'must display the duplicates' do
    out_stuff = all_stdout
    _(out_stuff).must_include 'very_small_black_dot_exact_copy.jpeg'
    _(out_stuff).must_include 'very_small_black_dot.jpeg'
  end

  it 'must not display unique files' do
    out_stuff = all_stdout
    _(out_stuff).wont_include 'very_small_blue_dot.jpeg'
  end
end