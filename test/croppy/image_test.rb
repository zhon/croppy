require "test_helper"

require 'croppy/image'

module Croppy


  describe Image do

    describe "crop" do

      it "calls instance of Crop.crop" do
        skip

        input = "~/Pictures/image.jpg"
        options = {}
        any_instance_of(Crop) do |item|
          mock(item).crop.with_any_args
        end

        Crop::crop input, options

      end
    end

  end


end
