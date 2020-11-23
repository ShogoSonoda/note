class PostsController < ApplicationController
  before_action :

  def index
    @posts = Post.all
  end
end
