class Post < ApplicationRecord
  belongs_to :user
  has_many :comments
  has_many :liked_users, through: :likes, source: :user

  with_options presence: true do
    validates :title
    validates :text
    validates :user_id
  end

  def self.search(search)
    if search != ""
      Post.where('text LIKE(?)', "%#{search}%")
    else
      Post.all
    end
  end

  def already_liked?(post)
    self.likes.exists?(post_id: post.id)
  end
end
