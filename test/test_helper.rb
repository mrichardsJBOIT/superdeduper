$LOAD_PATH.unshift File.expand_path('../lib', __dir__)
require 'superdeduper'
require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/spec'
require 'aruba'
require 'aruba/api'
require 'aruba/command'
Minitest::Reporters.use!
