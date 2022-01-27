class CreateLiveries < ActiveRecord::Migration[6.1]
  def change
    create_table :liveries do |t|

      t.timestamps
    end
  end
end
