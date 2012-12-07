class User < ActiveRecord::Base
  attr_accessible :email, :gender, :image, :location, :name, :oauth_expires_at, :oauth_token, :provider, :uid, :ProfilePicFullURL
	
	def self.from_omniauth(auth)
	  where(auth.slice(:provider, :uid)).first_or_initialize.tap do |user|
	    
	    logger.info 'TalkLocal: AuthInfo'
	    logger.info auth.to_yaml

	    user.provider = auth.provider
	    user.uid = auth.uid
	    user.name = auth.info.name
	    user.email = auth.info.email
	    user.gender = auth.extra.raw_info.gender
	    user.image = auth.info.image
	    user.location = auth.info.location

	    user.oauth_token = auth.credentials.token
	    user.oauth_expires_at = Time.at(auth.credentials.expires_at)
	    user.save!

	    me = User.where(uid: user.uid)[0].facebook.get_object("me")
	    
	    logger.debug 'TalkLocal: Facebook::get_object("me")'
		logger.debug me.to_yaml

		user.bio = me["bio"]
		user.likes = me["likes"]
		user.birthday = me["birthday"]
	    user.save!

	    data = u.facebook.get_picture("me", width: "320", height: "480")
	    user.ProfilePicFullURL = data["picture"]["data"]["url"];
	    user.save!

	  end
	end

	def facebook
		@facebook ||= Koala::Facebook::API.new(oauth_token)
		block_given? ? yield(@facebook) : @facebook
	rescue Koala::Facebook::APIError => e
		logger.info e.to_s
		nil	
	end

	def count_friends
		facebook { |fb| fb.get_connection("me", "friends").size }
	end
end
