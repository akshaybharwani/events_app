class EventCategory < ApplicationRecord
  has_many :events, optional: true
end
