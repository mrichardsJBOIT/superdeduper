# frozen_string_literal: true

require 'test_helper'
require 'fileutils'

describe 'Command', type: :aruba do
  include Aruba::Api
  before do
    setup_aruba
    Aruba.configure do |config|
      src = File.join(Dir.pwd, 'test/fixtures')
      dest = File.join(Dir.pwd, config.working_directory)
      FileUtils.copy_entry(src, dest)
    end
  end


  describe 'when passed a folder with duplicates', type: :aruba do
    let(:args) { '-d .' }
    before do
      setup_aruba(false)
      run_command("superdeduper #{args}")
    end

    it 'displays the duplicate files' do
      out_stuff = all_stdout
      _(out_stuff).must_include 'very_small_black_dot_exact_copy.jpeg'
      _(out_stuff).must_include 'very_small_black_dot.jpeg'
    end

    it 'does not display unique files' do
      out_stuff = all_stdout
      _(out_stuff).wont_include 'very_small_blue_dot.jpeg'
      _(out_stuff).wont_include 'some_other_non_image_file.txt'
    end
  end

  describe 'when passed a specific filter', type: :aruba do
    before do
      setup_aruba(false)
    end

    it 'displays only filtered duplicate files' do
      args = '-d . -f*.jpeg'
      run_command("superdeduper #{args}")
      out_stuff = all_stdout
      _(out_stuff).must_include 'very_small_black_dot_exact_copy.jpeg'
      _(out_stuff).must_include 'very_small_black_dot.jpeg'
    end

    it 'does not display filtered files' do
      args = '-d . -f*.txt'
      run_command("superdeduper #{args}")
      out_stuff = all_stdout
      _(out_stuff).wont_include 'very_small_black_dot_exact_copy.jpeg'
      _(out_stuff).wont_include 'very_small_black_dot.jpeg'
    end
  end

  describe 'when passed a generic filter', type: :aruba do
    let(:args) { '-d . -f*.*' }
    before do
      setup_aruba(false)
      run_command("superdeduper #{args}")
    end

    it 'displays all duplicate files' do
      out_stuff = all_stdout
      _(out_stuff).must_include 'very_small_black_dot_exact_copy.jpeg'
      _(out_stuff).must_include 'very_small_black_dot.jpeg'
    end

    it 'does not display unique files' do
      out_stuff = all_stdout
      _(out_stuff).wont_include 'some_other_non_image_file.txt'
      _(out_stuff).wont_include 'very_small_blue_dot.jpeg'
    end
  end

  describe 'when passed a compressed file' do
    # let(:args) { '-z images.zip' }
    before do
      # setup_aruba(false)
      # run_command("superdeduper #{args}")
    end
    it 'displays all duplicate files' do
      # out_stuff = all_stdout
      # _(out_stuff).must_include 'very_small_black_dot_exact_copy.jpeg'
      # _(out_stuff).must_include 'very_small_black_dot.jpeg'
    end

    it 'does not display unique files' do
      # out_stuff = all_stdout
      # _(out_stuff).wont_include 'some_other_non_image_file.txt'
      # _(out_stuff).wont_include 'very_small_blue_dot.jpeg'
    end
  end

  after do
    setup_aruba
  end


end
