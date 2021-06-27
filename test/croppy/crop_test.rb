require "test_helper"

require 'croppy/crop'
require 'croppy/magick'

module Croppy

  describe Crop do

    describe "crop" do

      it "calls of Magick.to_square_with_blur with option blur" do
        input = "~/Pictures/image.jpg"
        options = { background: :blur }
        mock(Magick).dimensions(input) { [2,3] }
        mock(Magick).to_square_with_blur.with_any_args

        Crop::crop input, options
      end

    end

    describe "tile" do

      it "calls instance of Crop.tile" do
        skip

        input = "~/Pictures/image.jpg"
        options = {}
        any_instance_of(Crop) do |item|
          mock(item).tile.with_any_args
        end

        Crop::tile input, options

      end

    end


  end

end
