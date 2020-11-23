class Post < ApplicationRecord
  with_options presence: true do
    validates :title
    validates :text
  end
end
