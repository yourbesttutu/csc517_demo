class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.string :isbn
      t.string :title
      t.string :author
      t.string :description
      t.string :status

      t.timestamps null: false
    end
  end
end
