class New < ActiveRecord::Migration
  enable_extension 'hstore'
  def change
    create_table :repositories do |t|
      t.text :user
      t.text :repo_name
      t.text :refreshed
      t.text :stargazers
      t.text :lang
      t.text :percentage_pulls_merged
      t.text :contributors
      t.text :pulls_to_issues
      t.text :readme
      t.text :popularity
      t.text :growth_rate
      t.hstore :languages
    end
  end
end
