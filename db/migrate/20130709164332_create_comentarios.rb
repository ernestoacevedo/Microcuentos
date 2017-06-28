class CreateComentarios < ActiveRecord::Migration
  def change
    create_table :comentarios do |t|
      t.integer :microcuento_id
      t.text :contenido

      t.timestamps
    end
    add_index :comentarios, :microcuento_id
  end
end
