class Users::AlbumsController < Users::UsersController

  before_filter :fetch_user

  def index
    @user_albums = @user.fetch_albums
  end

  def show_album
    @album_pictutes = @user.fetch_album_pictures(params[:album_url])
    @comment = Comment.new
  end

private

  def fetch_user
    @user = User.find_by_google_id(params[:user_id]).first
  end
end
