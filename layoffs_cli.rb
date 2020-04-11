require 'thor'
require 'readline'
require_relative './config/initializer'
require_relative './lib/layoffs'

class LayoffsCLI < Thor
    class_option :verbose, :type => :boolean, :aliases => "-v"

    desc "Fetch spreadsheet, create database", "Create a new rails app"
    def i
        Commands.interactive
    end
end