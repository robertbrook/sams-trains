class CreatePerformanceScores < ActiveRecord::Migration[6.1]
  def change
    create_table :performance_scores do |t|

      t.timestamps
    end
  end
end
