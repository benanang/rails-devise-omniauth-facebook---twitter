class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
	devise :omniauthable


  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :uid, :provider, :screen_name, :name
  # attr_accessor :display_username

  def display_username
  	if self.provider == "facebook"
			self.email
	  else
	  	self.screen_name
	  end
  end

	def self.find_for_facebook_oauth(access_token, signed_in_resource=nil)
	  data = access_token.extra.raw_info
	  if user = User.where(:email => data.email).first
	    user
	  else # Create a user with a stub password. 
	    User.create!(
	    	:email => data.email, 
	    	:password => Devise.friendly_token[0,20],
	    	:provider => access_token.provider,
	    	:name => access_token.info.name
	    	) 
	  end
	end

	def self.find_for_twitter_oauth(access_token, signed_in_resource=nil)
	  data = access_token.extra.raw_info
	  logger.debug "xx access_token.info #{access_token.info}"
	  logger.debug "xx access_token.provider #{access_token.provider} uid #{access_token.uid}"
	  if user = User.where(:uid => access_token.uid, :provider => access_token.provider).first
	    user
	  else # Create a user with a stub password. 
	  	logger.debug "xx find_for_twitter_oauth bawah"
	    User.create!(
	    	:uid => "#{access_token.uid}", 
	    	:password => Devise.friendly_token[0,20], 
	    	:provider => "#{access_token.provider}", 
	    	:screen_name => data.screen_name, 
	    	:name => data.name, 
	    	:email => "#{data.screen_name}@twitter.com"
	    	) 
	  end
	end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"]
      end
    end
  end
end