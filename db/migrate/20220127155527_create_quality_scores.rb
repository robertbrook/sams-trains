class CreateQualityScores < ActiveRecord::Migration[6.1]
  def change
    create_table :quality_scores do |t|

      t.timestamps
    end
  end
end
