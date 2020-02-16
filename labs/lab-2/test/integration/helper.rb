ENV['RACK_ENV'] = 'test'
require 'capybara'
require 'capybara/dsl'
require 'minitest/autorun'
require 'rack/test'

require_relative '../../app'
