BadgesEngine::Configuration.setup do |config|
	config.issuer = {
		name: 'RAM Mounts',
		url: 'http://frozen-dawn-78535.herokuapp.com/'
	}
	config.baker_url = 'http://bakery.openbadges.org'
	config.badge_version = '0.1.0'
	config.user_class = User
end
