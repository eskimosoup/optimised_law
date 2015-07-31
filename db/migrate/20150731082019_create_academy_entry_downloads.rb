class CreateAcademyEntryDownloads < ActiveRecord::Migration
  def change
    create_table :academy_entry_downloads do |t|
      t.string :forename, null: false
      t.string :surname, null: false
      t.string :email, null: false
      t.integer :academy_entry_id

      t.timestamps null: false
    end

    add_index :academy_entry_downloads, :academy_entry_id
  end
end
