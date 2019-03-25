class CreateMemberships < ActiveRecord::Migration[5.2]
  def change
    create_table :memberships do |t|
      t.references :user, foreign_key: true
      t.references :club, foreign_key: true
      t.boolean :host, default: false 
      t.boolean :admin, default: false

      t.timestamps
    end
  end
end
