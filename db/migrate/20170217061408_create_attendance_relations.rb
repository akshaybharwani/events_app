class CreateAttendanceRelations < ActiveRecord::Migration[5.0]
  def change
    create_table :attendance_relations do |t|
      t.integer :attendee_id
      t.integer :attended_event_id

      t.timestamps
    end
    add_index :attendance_relations, :attendee_id
    add_index :attendance_relations, :attended_event_id
    add_index :attendance_relations, [:attendee_id, :attended_event_id], unique: true
  end
end
