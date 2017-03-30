class EventCategory < ApplicationRecord
  has_many :events

  def self.options_for_select
    order('LOWER(name)').map { |e| [e.name, e.id] }
  end

end
