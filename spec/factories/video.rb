FactoryGirl.define do
  factory :video, :class => 'refinery/video' do
    raw Refinery.roots("videos").join("spec/samples/test-movie.mov")
  end
end
