class CreateDislikes < ActiveRecord::Migration
  def change
    create_table :dislikes do |t|
      t.references :quote, index: true

      t.timestamps
    end
  end
end
