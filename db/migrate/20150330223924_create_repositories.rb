class CreateRepositories < ActiveRecord::Migration
  def change
    create_table :repositories do |t|
      t.string :info
      t.string :contributors
      t.string :languages
      t.integer :pulls
      t.boolean :read_me
      t.integer :popularity
      t.integer :growth

      t.timestamps null: false
    end
  end
end
