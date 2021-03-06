class Sub < ApplicationRecord
  validates :title, :description, :moderator_id, presence: true
  validates :title, uniqueness: true

  belongs_to( 
    :mod,
    class_name: "User",
    foreign_key: :moderator_id,
    primary_key: :id
    ) 
  has_many :post_subs, inverse_of: :sub
  has_many :posts, through: :post_subs
    
end
