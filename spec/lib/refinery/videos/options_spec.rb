require 'spec_helper'

module Refinery
  describe Videos::Options do
    describe ".reset!" do
      it "should set use_nginx_upload_module back to the default value" do      
        subject.class.use_nginx_upload_module.should == subject.class::DEFAULT_USE_NGINX_UPLOAD_MODULE
        subject.class.use_nginx_upload_module = true
        subject.class.use_nginx_upload_module.should_not == subject.class::DEFAULT_USE_NGINX_UPLOAD_MODULE
        subject.class.reset!
        subject.class.use_nginx_upload_module.should == subject.class::DEFAULT_USE_NGINX_UPLOAD_MODULE
      end
      
      it "should set upload_progress_uri back to the default value" do      
        subject.class.upload_progress_uri.should == subject.class::DEFAULT_UPLOAD_PROGRESS_URI
        subject.class.upload_progress_uri = '/something/progress'
        subject.class.upload_progress_uri.should_not == subject.class::DEFAULT_UPLOAD_PROGRESS_URI
        subject.class.reset!
        subject.class.upload_progress_uri.should == subject.class::DEFAULT_UPLOAD_PROGRESS_URI
      end
    end
  end
end
