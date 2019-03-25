class CreateMeetings < ActiveRecord::Migration[5.2]
  def change
    create_table :meetings do |t|
      t.references :book, foreign_key: true
      t.references :club, foreign_key: true
      t.boolean :current, default: true
      t.datetime :date_time
      t.string :location

      t.timestamps
    end
  end
end
