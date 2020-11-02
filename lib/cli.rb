require 'thor'

module Croppy
  class CLI < Thor

    private

    # read options from config file and override with command line
    def options
      original_options = super
      filename = original_options[:file] || '.csvconverter.yaml'
      return original_options unless File.exists?(filename)
      defaults = ::YAML::load_file(filename) || {}
      defaults.merge(original_options)
      # alternatively, set original_options[:langs] and then return it
    end

  end
end
