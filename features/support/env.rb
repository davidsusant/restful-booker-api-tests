# features/support/env.rb
require 'httparty'
require 'json'
require 'faker'
require 'dotenv/load'
require 'allure-cucumber'

Dotenv.load

BASE_URL = 'https://restful-booker.herokuapp.com'

require_relative 'api_helper'
