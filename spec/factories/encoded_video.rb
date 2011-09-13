FactoryGirl.define do
  factory :encoded_video, :class => Refinery::EncodedVideo do
    file Refinery::Videos::Engine.root.join("spec/samples/test-movie.mov")
    
    association :raw_video, :factory => :raw_video
  end
end
