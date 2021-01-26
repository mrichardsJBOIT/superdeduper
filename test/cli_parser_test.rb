require 'test_helper'

class CliParserTest < Minitest::Test
  def setup
    @current_directory = Dir.pwd.to_s.strip
  end

  def test_parser_reads_short_directory
    args = ["-d #{@current_directory}"]
    parser = Superdeduper::DuperCliParser.new(args)
    parser.parse
    assert_match(@current_directory, parser.option('directory'), parser.option('directory'))
  end

  def test_parser_reads_long_directory
    args = ["--DIRECTORY=#{@current_directory}"]
    parser = Superdeduper::DuperCliParser.new(args)
    parser.parse
    assert_match(@current_directory, parser.option('directory'), parser.option('directory'))
  end

  def test_parser_provides_invalid_argument_message
    args = ['-d NO_DIRECTORY']
    parser = Superdeduper::DuperCliParser.new(args)
    error = assert_raises(Superdeduper::CliParsingError, 'This should have raised CliParsingError') do
      parser.parse
    end
    assert error.to_s.match?('invalid argument: -d NO_DIRECTORY')
  end

  def test_parser_provides_invalid_option_message
    args = ['-X=OOPS']
    parser = Superdeduper::DuperCliParser.new(args)
    error = assert_raises(Superdeduper::CliParsingError, 'This should have raised CliParsingError') do
      parser.parse
    end
    assert error.to_s.match?('-X')
  end

  def test_parser_defaults_to_current_directory
    args = nil
    parser = Superdeduper::DuperCliParser.new(args)
    parser.parse
    assert_match(@current_directory, parser.option('directory'), parser.option('directory'))
  end

  def test_parser_reads_short_filter
    args = ['-f*.jpeg']
    parser = Superdeduper::DuperCliParser.new(args)
    parser.parse
    assert_match('*.jpeg', parser.option('filter'), parser.option('filter'))
  end

  def test_parser_reads_generic_short_filter
    args = ['-f*.*']
    parser = Superdeduper::DuperCliParser.new(args)
    parser.parse
    assert_match('*.*', parser.option('filter'), parser.option('filter'))
  end

  def test_parser_filter_invalid_argument_message
    args = ['-f*.jp$g']
    parser = Superdeduper::DuperCliParser.new(args)
    error = assert_raises(Superdeduper::CliParsingError, 'This should have raised CliParsingError') do
      parser.parse
    end
    assert error.to_s.match?('invalid argument')
  end
end

