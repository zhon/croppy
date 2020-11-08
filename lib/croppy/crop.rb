require 'croppy/magick'

module Croppy

    class Crop

      def self.crop input


      end

      def initialize input_dir, output_dir
        @input_dir = input_dir
        @output_dir = output_dir
      end

      def crop(filename)
        input = "#{@input_dir}/#{filename}"
        output = "#{@output_dir}/#{filename}"

        dimensions = Magick::dimensions input

        size = dimensions.max
        Magick::crop(input, size, size, output)
      end


    end

end


