class AddAttendeeCountToEvents < ActiveRecord::Migration[5.0]
  def change
    add_column :events, :attendee_count, :integer, default: 0
  end
end
