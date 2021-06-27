require 'croppy/image'

require 'pathname'

# new name for croppy gramit

module Croppy

    class Crop

      def self.crop input, options
        pn = Pathname.new input
        if pn.directory?
          files = Dir.glob "#{input}/*.jpg"
          files.each do |item|
            Image.new(item).crop("#{input}/cropped", options)
          end
        else
          output = "#{pn.dirname}/cropped"
          Image.new(input).crop(output, options)
        end
      end

      def self.tile input, options

      end

      def initialize input_dir, output_dir
        # todo make sure the output dir exists
        @input_dir = input_dir
        @output_dir = output_dir
      end

    end

end


