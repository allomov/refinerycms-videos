FactoryGirl.define do
  factory :video, :class => 'refinery/video' do
    raw Refinery::Videos::Engine.root.join("spec/samples/test-movie.mov")
  end
end
