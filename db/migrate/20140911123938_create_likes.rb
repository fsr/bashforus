class CreateLikes < ActiveRecord::Migration
  def change
    create_table :likes do |t|
      t.references :quote, index: true

      t.timestamps
    end
  end
end
