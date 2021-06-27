
require 'croppy/magick'

module Croppy

    class Image

      def initialize filename
        @filename = filename
        @basename = Pathname.new(filename).basename.to_s
      end

      def crop(output_dir, options)
        output = "#{output_dir}/#{@basename}"

        dimensions = Magick::dimensions @filename

        size = dimensions.max + 2
        case options[:border].to_sym
        when :blur
          Magick::to_square_with_blur(@filename, output, size)
        else
          raise "Unimplemented"
        end

        #size = dimensions.max + 2
        #Magick::crop(input, size, size, output)
        #Magick::to_square(input, output, size)
      end

    end

end

