require 'thor'

require 'logger'

require 'croppy/crop'

module Croppy

  $logger = Logger.new File.new(Dir.home + '/croppy.log', File::WRONLY | File::APPEND | File::CREAT)
  #$logger = Logger.new STDOUT

  class CLI < Thor
    OPTIONS_FILENAME = '.croppy.yaml'

    class_option :verbose, :type => :boolean

    desc "crop INPUT", "crop INPUT (file or directory)"
    long_desc <<-LONGDESC
      `crop INPUT` will crop the INPUT which can be a image file or a directory
      of image files.

      > $ croppy /Users/zhon/Pictures/Instagram/

      > $ croppy /Users/zhon/Pictures/Instagram/image.jpg

      options can be stored in ~/#{OPTIONS_FILENAME}
    LONGDESC
    option :border, aliases: '-b', type: :string, default: :blur, desc: "blur, black, white"
    #option '', alias: '-d', type: :boolean, desc: "perform a trial run with no changes made"
    #option :dest, desc: 'backup to this distination'
    def crop input
      $logger.info("cropping #{input}")

      Crop.crop input, options
    end

    desc "tile INPUT", "tile INPUT (image filename)"
    long_desc <<-LONGDESC
      `tile INPUT` will tile the INPUT which can be a image file or a directory
      of image files.

      > $ croppy /Users/zhon/Pictures/Instagram/image.jpg

      options can be stored in ~/#{OPTIONS_FILENAME}
    LONGDESC
    option :border, aliases: '-b', type: :string, default: :blur, desc: "blur, black, white"
    def tile input
      $logger.info("tiling #{input}")

      Crop.tile input, options
    end



    #allows arguments to the default comand without specifing the command
    def method_missing(method, *args)
      args = ["crop", method.to_s] + args
      CLI.start(args)
    end

    default_task :crop

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
