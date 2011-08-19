require 'spec_helper'

module Refinery
  describe Video do
    let!(:video) { Factory(:video) }
    
    describe "validations" do
      it "rejects nil value for raw" do
        Video.new(@valid_attributes.merge(:raw => nil)).should_not be_valid
      end
    end

  end
end
