class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :chapter
  has_many :childs, class_name: Comment.name, foreign_key: :parent_id,
    dependent: :destroy
  belongs_to :parent, class_name: Comment.name, optional: true

  validates :content, presence: true,
                      length: {maximum: Settings.comment.content.max_length}

  acts_as_tree order: "created_at DESC"

  scope :order_comments, ->{order created_at: :desc}
end
