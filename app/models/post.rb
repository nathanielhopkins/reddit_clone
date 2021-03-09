class Post < ApplicationRecord
  validates :title, :author_id, presence: true
  validates :post_subs, presence: true

  belongs_to(
    :author,
    class_name: "User",
    foreign_key: :author_id,
    primary_key: :id
  )
  has_many :post_subs, dependent: :destroy, inverse_of: :post
  has_many :subs, through: :post_subs
  has_many :comments
  has_many :votes, as: :votable

  def comments_by_parent_id
    sorted_comments = {}
    self.comments.includes(:author).each do |comment|
      sorted_comments[comment.parent_comment_id] ||= []
      sorted_comments[comment.parent_comment_id] << comment
    end
    sorted_comments
  end

  def score
    score = 0
    self.votes.each do |vote|
      score += vote.value if vote.value
    end
    score
  end
end
