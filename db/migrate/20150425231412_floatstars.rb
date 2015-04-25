class Floatstars < ActiveRecord::Migration
  def change
    change_table :repositories do |t|
      t.remove :growth_rate
      t.float :growth_rate
    end
  end
end
