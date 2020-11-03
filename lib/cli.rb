require 'thor'

module Croppy
  class CLI < Thor
    OPTIONS_FILENAME = '.croppy.yaml'



    no_commands do

      # read options from config file and override with command line
      def options
        return @my_options || ( @my_options = Options.new(super, OPTIONS_FILENAME).options )
      end

    end

    class Options
      attr_reader :options

      def initialize(opts, filename)
        if File.exist?(filename)
          @options = ::YAML.load_file(filename) || {}
          @options.merge!(opts)
        else
          @options = opts
        end
      end
    end

  end
end
