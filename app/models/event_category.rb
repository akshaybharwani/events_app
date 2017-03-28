class EventCategory < ApplicationRecord
  belongs_to :event, optional: true
end
