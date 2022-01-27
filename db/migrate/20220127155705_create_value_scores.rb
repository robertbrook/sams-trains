class CreateValueScores < ActiveRecord::Migration[6.1]
  def change
    create_table :value_scores do |t|

      t.timestamps
    end
  end
end
