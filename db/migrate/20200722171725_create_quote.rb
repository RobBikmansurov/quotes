class CreateQuote < ActiveRecord::Migration[6.0]
  def change
    create_table :quotes do |t|
      t.string :text
      t.string :author_name
      t.references :author, null: false, foreign_key: true
    end
  end
end
