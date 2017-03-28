class Event < ApplicationRecord
  belongs_to :creator, class_name: 'User'
  default_scope -> { order(attendee_count: :desc, created_at: :desc) }
  mount_uploader :picture, PictureUploader
  validates :creator_id, presence: true
  validates :title, presence: true#, length: { maximum: 30 }
  validates :description, presence: true, length: { maximum: 100 }
  validate  :picture_size
  has_many :attendance_relations, foreign_key: 'attended_event_id',
           dependent: :destroy
  has_many :attendees,            through: :attendance_relations
  has_many :event_categories
  private

  # Validates the size of an uploaded picture.
  def picture_size
    if picture.size > 5.megabytes
      errors.add(:picture, "should be less than 5MB")
    end
  end
end
