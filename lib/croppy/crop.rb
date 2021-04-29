require 'croppy/magick'

require 'pathname'

module Croppy

    class Crop

      def self.crop input
        pn = Pathname.new input
        crop = nil
        if pn.directory?
          crop = Crop.new input, "#{input}/cropped"
          files = Dir.glob "#{input}/*.jpg"
          files.each do |item|
            crop.crop File.basename(item)
          end
        else
          crop = Crop.new pn.dirname, "#{pn.dirname}/cropped"
          crop.crop pn.basename
        end
      end

      def initialize input_dir, output_dir
        # todo make sure the output dir exists
        @input_dir = input_dir
        @output_dir = output_dir
      end

      def crop(filename)
        input = "#{@input_dir}/#{filename}"
        output = "#{@output_dir}/#{filename}"

        dimensions = Magick::dimensions input

        size = dimensions.max + 2
        #Magick::crop(input, size, size, output)
        #Magick::to_square_with_blur(input, output, size)
        Magick::to_square(input, output, size)
      end


    end

end


