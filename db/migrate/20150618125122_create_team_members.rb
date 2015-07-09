class CreateTeamMembers < ActiveRecord::Migration
  def change
    create_table :team_members do |t|
      t.string :name
      t.text :profile
      t.string :image
      t.string :tag_line
      t.string :google_plus
      t.string :twitter
      t.boolean :display, default: true
      t.integer :position
      t.string :job_title
      t.boolean :director, default: false
      t.string :sector

      t.timestamps null: false
    end
  end
end
