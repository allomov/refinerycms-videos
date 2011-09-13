FactoryGirl.define do
  factory :encoded_video, :class => Refinery::EncodedVideo do
    video Refinery::Videos::Engine.root.join("spec/samples/test-movie.mov")
    
    association :raw, :factory => :raw_video
  end
end
