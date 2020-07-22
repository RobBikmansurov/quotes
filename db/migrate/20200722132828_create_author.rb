class CreateAuthor < ActiveRecord::Migration[6.0]
  def change
    create_table :authors do |t|
      t.string :name
      t.string :note
      t.string :link
    end
  end
end
