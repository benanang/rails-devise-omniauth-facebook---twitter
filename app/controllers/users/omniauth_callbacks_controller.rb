class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    # You need to implement the method below in your model
    logger.debug "xx signed_in? #{user_signed_in?} && current_user #{current_user}"
    logger.debug "xx #{request.env['omniauth.auth']}"
    @user = User.find_for_facebook_oauth(request.env["omniauth.auth"], current_user)

    if @user.persisted?
      logger.debug "xx atas"
      flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => "Facebook"
      logger.debug "xx2 signed_in? #{user_signed_in?} && current_user #{current_user}"
      sign_in_and_redirect @user, :event => :authentication
    else
      logger.debug "xx bawah"
      session["devise.facebook_data"] = request.env["omniauth.auth"]
      redirect_to new_user_registration_url
    end
  end

  def twitter
    logger.debug "xx atas #{request.env["omniauth.auth"]}"
    @user = User.find_for_twitter_oauth(request.env["omniauth.auth"], current_user)
    if @user.persisted?
      logger.debug "xx atas"
      flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => "Twitter"
      logger.debug "xx2 signed_in? #{user_signed_in?} && current_user #{current_user}"
      sign_in_and_redirect @user, :event => :authentication
    else
      logger.debug "xx bawah"
      session["devise.twitter_data"] = request.env["omniauth.auth"]
      redirect_to new_user_registration_url
    end
  end

  def auth_hash
    request.env['omniauth.auth']
  end
end