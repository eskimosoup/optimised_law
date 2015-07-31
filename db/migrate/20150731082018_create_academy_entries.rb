class CreateAcademyEntries < ActiveRecord::Migration
  def change
    create_table :academy_entries do |t|
      t.string :title, null: false
      t.string :image, null: false
      t.string :level, null: false
      t.string :pdf_download, null: false
      t.text :summary, null: false
      t.text :mailchimp_form, null: true
      t.string :mailchimp_frequency, null: true
      t.string :slug, unique: true
      t.boolean :display, default: true

      t.timestamps null: false
    end
  end
end
