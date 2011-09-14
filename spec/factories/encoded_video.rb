FactoryGirl.define do
  factory :encoded_video, :class => Refinery::EncodedVideo do
    file Refinery::Videos::Engine.root.join("spec/samples/test-movie.mov")
    format 'mp4'
    
    association :raw_video, :factory => :raw_video
    
    factory :encoded_video_mp4 do
      format 'mp4'
    end
    
    factory :encoded_video_ogv do
      format 'ogv'
    end
    
    factory :encoded_video_webm do
      format 'webm'
    end
  end
end
