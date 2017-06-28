class AddAttachmentPortadaToMicrocuentos < ActiveRecord::Migration
  def self.up
    change_table :microcuentos do |t|
      t.attachment :portada
    end
  end

  def self.down
    drop_attached_file :microcuentos, :portada
  end
end
