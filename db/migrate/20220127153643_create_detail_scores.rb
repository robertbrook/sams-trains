class CreateDetailScores < ActiveRecord::Migration[6.1]
  def change
    create_table :detail_scores do |t|

      t.timestamps
    end
  end
end
