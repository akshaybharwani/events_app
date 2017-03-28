class AddEventCategoryRefToEvents < ActiveRecord::Migration[5.0]
  def change
    add_reference :events, :event_category, foreign_key: true
  end
end
