require "test_helper"

require 'croppy/crop'

module Croppy

  describe Crop do

    describe "crop" do

      it "calls instance of Crop.crop" do
        input = "~/Pictures/image.jpg"
        options = {}
        any_instance_of(Crop) do |item|
          mock(item).crop.with_any_args
        end

        Crop::crop input, options

      end
    end


    it "" do
    end

  end

end
