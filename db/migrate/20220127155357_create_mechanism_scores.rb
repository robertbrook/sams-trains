class CreateMechanismScores < ActiveRecord::Migration[6.1]
  def change
    create_table :mechanism_scores do |t|

      t.timestamps
    end
  end
end
