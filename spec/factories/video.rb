FactoryGirl.define do
  factory :video, :class => Refinery::Video do
    video Refinery::Videos::Engine.root.join("spec/samples/test-movie.mov")
    
    factory :video_with_encoded do
      after_create { |video| FactoryGirl.create(:encoded_video, :raw => video) }
    end
  end
end
