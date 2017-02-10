class CreateEvents < ActiveRecord::Migration[5.0]
  def change
    create_table :events do |t|
      t.string :title
      t.text :description
      t.references :user, foreign_key: true

      t.timestamps
    end
    add_index :events, [:user_id, :created_at]
  end
end
