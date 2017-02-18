class AttendanceRelation < ApplicationRecord
  belongs_to :attendee,       class_name: "User"
  belongs_to :attended_event, class_name: "Event", counter_cache: :attendee_count

  validates :attendee_id,       presence: true
  validates :attended_event_id, presence: true
end
