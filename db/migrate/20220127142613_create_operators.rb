class CreateOperators < ActiveRecord::Migration[6.1]
  def change
    create_table :operators do |t|

      t.timestamps
    end
  end
end
