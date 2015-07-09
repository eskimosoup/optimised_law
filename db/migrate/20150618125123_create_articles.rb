class CreateArticles < ActiveRecord::MigrationHMZTXEEEXA9UN7
  def change
    create_table :articles do |t|
      t.string :title, null: false
      t.string :slug
      t.text :content, null: false
      t.text :video
      t.string :infographic
      t.date :date
      t.boolean :display, default: true
      t.text :summary
      t.belongs_to :team_member, index: true, foreign_key: true
      t.string :approach
      t.string :image
      t.string :guide
      t.boolean :academy_content, default: false
      t.boolean :news_content, default: true

      t.timestamps null: false
    end
  end
end
