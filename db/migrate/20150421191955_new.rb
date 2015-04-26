class New < ActiveRecord::Migration
  enable_extension 'hstore'
  def change
    create_table :repositories do |t|
      t.text :user
      t.text :repo_name
      t.datetime :refreshed
      t.datetime :created
      t.integer :stars
      t.text :lang
      t.integer :pulls_merged
      t.integer :contributors
      t.integer :pulls_to_issues
      t.boolean :readme
      t.integer :popularity
      t.integer :growth_rate
      t.hstore :languages
    end
  end
end
