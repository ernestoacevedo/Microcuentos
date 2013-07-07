class CreateMicrocuentos < ActiveRecord::Migration
  def change
    create_table :microcuentos do |t|
      t.string :title
      t.integer :user_id
      t.integer :likes
      t.text :content

      t.timestamps
    end
  end
end
