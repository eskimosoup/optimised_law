class CreateChroniclerTables < ActiveRecord::Migration
  def change
    create_table :chronicler_documents  do |t|
      t.string :name
      t.string :document
      t.timestamps
    end
    
    create_table :chronicler_images  do |t|
      t.string :name
      t.string :image
      t.timestamps
    end
  end
end
