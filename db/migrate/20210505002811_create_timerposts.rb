class CreateTimerposts < ActiveRecord::Migration[6.1]
  def change
    create_table :timerposts do |t|
      t.integer :hour
      t.integer :minutes
      t.integer :second
      t.text :memo
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
    add_index :timerposts,[:user_id, :created_at]
  end
end
