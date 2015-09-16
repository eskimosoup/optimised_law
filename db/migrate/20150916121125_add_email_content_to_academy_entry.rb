class AddEmailContentToAcademyEntry < ActiveRecord::Migration
  def change
    add_column :academy_entries, :email_content, :text
  end
end
