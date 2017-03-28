class AddAdditionalFieldsToEvents < ActiveRecord::Migration[5.0]
  def change
    add_column :events, :start_date, :date
    add_column :events, :category,   :string
  end
end
