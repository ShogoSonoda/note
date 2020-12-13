class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  with_options presence: true do
    validates :title
    validates :text
    validates :user_id
  end

  def self.search(search)
    if search != ""
      Post.where('title LIKE(?) OR text LIKE(?)', "%#{search}%", "%#{search}%")
    else
      Post.all
    end
  end

  def liked_by?(user)
    likes.where(user_id: user.id).exists?
  end
end
