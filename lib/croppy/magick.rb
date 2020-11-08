require 'mini_magick'

module Croppy

  class Magick

    def self.dimensions(filename)
      MiniMagick::Image.open(filename).dimensions
    end


    def self.crop(input, width, height, output)
      MiniMagick::Tool::Convert.new do |c|
        c << input
        c.size "#{width}x#{height}"
        c << "xc:"
        c.swap.+
        c.gravity "center"
        c.composite
        c << output
      end
    end

  end
end

