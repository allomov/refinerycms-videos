require 'spec_helper'
require "generator_spec/test_case"

module Refinery
  describe VideosGenerator do
    include GeneratorSpec::TestCase
    destination File.expand_path("../../tmp", __FILE__)

    before(:each) do
      prepare_destination
      run_generator
    end

    specify do
      destination_root.should have_structure {
        directory "db" do
          directory "migrate"
        end
        directory "config" do
          directory "initializers" do
            file "refinery_videos.rb" do
              contains "Refinery::Videos::Options.configure"
            end
          end
        end
      }
    end
  end
end
