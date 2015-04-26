class Issues < ActiveRecord::Migration
  def change
    change_table :repositories do |t|
      t.remove :pulls_to_issues
      t.integer :issues
    end
  end
end
