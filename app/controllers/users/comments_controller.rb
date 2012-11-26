class Users::CommentsController < Users::UsersController

  def create
    @comment = Comment.new(params[:comment])
    @comment.user = current_user
    @comment.save!
    @comment[:author] = current_user.username
    respond_to do |format|
      format.js { render :layout => false }
    end
  end

  def index
    @comments = Comment.fetch_by_picture_id(params[:picture_id])
    sleep(1); # this for view porpose, should be removed in production
    render :text => @comments.to_json
  end

end
