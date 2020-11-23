class Post < ApplicationRecord
  with_options presence: true do
    validates :title
    validates :text
  end
  belongs_to :user
end
