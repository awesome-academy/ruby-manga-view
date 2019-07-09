class Comic < ApplicationRecord
  has_many :relationships, dependent: :destroy
  has_many :likes, through: :relationships, source: :relationshipable,
           source_type: :Like
  has_many :comic_followers, through: :relationships, source: :relationshipable,
           source_type: :comic_followers

  has_many :chapters, dependent: :destroy
  has_many :comic_categories, dependent: :destroy

  validates :name, presence: true,
                   length: {maximum: Settings.comic.name.max_length}
end
