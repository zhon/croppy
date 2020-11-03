require "test_helper"

require 'cli'

module Croppy
  describe "CLI" do

    it "options are the same for every instance called" do
      croppy = CLI.new
      refute_nil croppy.options
      assert croppy.options.__id__ == croppy.options.__id__

    end

    describe "CLI:Options" do

      it "with invalid filename only options are returned" do
        filename = 'invalid_filename'
        opts = {hello: :world}

        stub(File).exist?(filename) { false }

        options = CLI::Options.new(opts, filename)
        assert_equal opts, options.options
      end

      it "options are murged with config file options" do
        filename = 'invalid_filename'
        opts = {hello: 'world'}
        config_file_opts = {count: 1}

        stub(File).exist?(filename) { true }
        mock(::YAML).load_file(filename) { config_file_opts }

        options = CLI::Options.new(opts, filename)

        assert_equal opts.merge(config_file_opts), options.options
      end

    end


  end

end

