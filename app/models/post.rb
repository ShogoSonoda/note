class Post < ApplicationRecord
  belongs_to :user

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
end
