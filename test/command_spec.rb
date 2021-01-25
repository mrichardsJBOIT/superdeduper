require 'test_helper'

describe 'Command' do
  include Aruba::Api
  describe 'when passed a folder with duplicates', type: :aruba do
    before do
      setup_aruba
      run_command("superdeduper #{args}")
    end
    let(:args) { '-d ./fixtures' }
    it 'displays the duplicate files' do
      out_stuff = all_stdout
      _(out_stuff).must_include 'very_small_black_dot_exact_copy.jpeg'
      _(out_stuff).must_include 'very_small_black_dot.jpeg'
    end

    it 'does not display unique files' do
      out_stuff = all_stdout
      _(out_stuff).wont_include 'very_small_blue_dot.jpeg'
      _(out_stuff).wont_include 'some_non_image_file.txt'
    end
  end

  describe 'when passed a specific filter', type: :aruba do
    before do
      setup_aruba
      run_command("superdeduper #{args}")
    end
    let(:args) { '-d ./fixtures -f .jpeg' }
    it 'displays only filtered duplicate files' do
      out_stuff = all_stdout
      _(out_stuff).must_include 'very_small_black_dot_exact_copy.jpeg'
      _(out_stuff).must_include 'very_small_black_dot.jpeg'
    end

    let(:args) { '-d ./fixtures -f .txt' }
    it 'does not display filtered files' do
      out_stuff = all_stdout
      _(out_stuff).wont_include 'very_small_black_dot_exact_copy.jpeg'
      _(out_stuff).wont_include 'very_small_black_dot.jpeg'
    end
  end

  describe 'when passed a generic filter', type: :aruba do
    before do
      setup_aruba
      run_command("superdeduper #{args}")
    end
    let(:args) { '-d ./fixtures -f .*' }
    it 'displays all duplicate files' do
      out_stuff = all_stdout
      _(out_stuff).must_include 'very_small_black_dot_exact_copy.jpeg'
      _(out_stuff).must_include 'very_small_black_dot.jpeg'
    end

    let(:args) { '-d ./fixtures -f .txt' }
    it 'does not display filtered files' do
      out_stuff = all_stdout
      _(out_stuff).wont_include 'very_small_black_dot_exact_copy.jpeg'
      _(out_stuff).wont_include 'very_small_black_dot.jpeg'
    end
  end
end
