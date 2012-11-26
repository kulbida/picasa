class AuthenticationsController < ApplicationController

  def create
    user = User.find_for_google_oauth(auth_hash)
    if user.present?
      session[:uid] = user.id
      notice = "Howdy #{user.username}!"
    else
      notice = "User not found."
    end
    redirect_to root_path, :notice => notice
  end

  def destroy
    session[:uid] = nil
    redirect_to root_path, :notice => 'Bye!'
  end

private

  def auth_hash
    request.env['omniauth.auth']
  end

end
