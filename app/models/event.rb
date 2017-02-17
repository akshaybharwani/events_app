class Event < ApplicationRecord
  belongs_to :user
  default_scope -> { order(cached_votes_up: :desc, created_at: :desc) }
  mount_uploader :picture, PictureUploader
  validates :user_id, presence: true
  validates :title, presence: true#, length: { maximum: 30 }
  validates :description, presence: true, length: { maximum: 100 }
  validate  :picture_size
  acts_as_votable

  private

  # Validates the size of an uploaded picture.
  def picture_size
    if picture.size > 5.megabytes
      errors.add(:picture, "should be less than 5MB")
    end
  end
end
