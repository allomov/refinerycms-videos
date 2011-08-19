::Refinery::User.all.each do |user|
  if user.plugins.where(:name => 'videos').blank?
    user.plugins.create(:name => 'videos',
                        :position => (user.plugins.maximum(:position) || -1) +1)
  end
end

unless ::Refinery::Page.where(:menu_match => "^/videos(\/|\/.+?|)$").any?
  page = ::Refinery::Page.create(
    :title => 'Videos',
    :link_url => '/videos',
    :deletable => false,
    :show_in_menu => false,
    :position => ((::Refinery::Page.maximum(:position, :conditions => {:parent_id => nil}) || -1)+1),
    :menu_match => '^/videos(\/|\/.+?|)$'
  )
end
