class Comment < ApplicationRecord
  validates :content, :author, :post, presence: true

  belongs_to :post
  belongs_to(
    :author,
    class_name: "User",
    foreign_key: :author_id,
    primary_key: :id
  )
end
