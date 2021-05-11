class AddTitleToTimerposts < ActiveRecord::Migration[6.1]
  def change
    add_column :timerposts, :title, :string
  end
end
