class CommetsController < ApplicationController
  def create
    comment = Commet.create(comment_params)
    redirect_to "/posts/#{comment.post.id}"
  end

  private

  def comment_params
    params.require(:commet).permit(:text).merge(user_id: current_user.id, post_id: params[:post_id])
  end
end
