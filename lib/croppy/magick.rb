require 'mini_magick'

module Croppy

  class Magick

# create squares
#magick ~/Pictures/facebook/Instagram/20171118_17_26_49_33.jpg -crop 3x2@ +repage +adjoin tile-%d.jpg

    def self.dimensions(filename)
      MiniMagick::Image.open(filename).dimensions
    end


    def self.crop(input, width, height, output)
      MiniMagick::Tool::Convert.new do |c|
        c << input
        c.size "#{width}x#{height}"
        c << "canvas:"
        c.swap.+
        c.gravity "center"
        c.composite
        c << output
      end
    end

    def self.to_square(input, output, size, border:)


  #c.bordercolor border
  #c.border "#{(size - image.dimensions[0])/2}x#{(size - image.dimensions[1])/2}"

      MiniMagick::Tool::Convert.new do |c|
        c << input
        c.stack do |s|
          s.clone 0
          s.resize "#{size}x#{size}!"
          s.blur "0x20"
          s.fill :grey
          s.colorize '90%'
        end
        c.stack do |s|
          s.clone 0
          s.bordercolor :grey
          s.border '1x1'
        end
        c.delete 0
        c.gravity :center
        c.compose :over
        c.composite
        c << output
      end
    end

    def self.to_square_with_blur(input, output, size)

      MiniMagick::Tool::Convert.new do |c|
        c << input
        c.stack do |s|
          s.clone 0
          s.resize "#{size}x#{size}!"
          s.blur "0x20"
          s.fill :white
          s.colorize '5%'
        end
        c.stack do |s|
          s.clone 0
          s.bordercolor 'black'
          s.border '1x1'
        end
        c.delete 0
        c.gravity :center
        c.compose :over
        c.composite
        c << output
      end
    end


  end
end

=begin
  magick identify rose:

  Split up an Phi cropped image by adding in overlapping data
  magick test.jpg -crop 2x3+27@ +repage +adjoin cropped/rose_3x3@_%d.gif

  Split up a 2x3 cropped image into
  magick test.jpg -crop 2x3@ +repage +adjoin cropped/test_2x3@_%d.gif

  This one doesn't work correctly

  magick test.jpg -size 720x1080 canvas: +swap -gravity center -composite -crop 2x3@ +repage +adjoin cropped/rose_2x3@_%d.gif

  These commands work but require a temp file
  magick test.jpg -size 720x1080 canvas: +swap -gravity center -composite test2.jpg
  magick test2.jpg -crop 2x3@ +repage +adjoin cropped/rose_3x3@_%d.gif


  magick rose: -size 84x55 canvas: +swap -gravity center -composite  rose.jpg
  magick rose.jpg   -crop 3x2@ +repage +adjoin cropped/rose@_%d.gif

  magick rose: -size 84x55 canvas: +swap -gravity center -composite +repage  -crop 3x2@ +repage +adjoin cropped/rose@_%d.gif

  magick test.jpg -gravity center -background white -extent 720x1080 -crop 2x3@ +repage cropped/test%d.png
  magick rose: -gravity center -background white -extent 84x55 -crop 3x2@ +repage rose-%d.gif
=end

