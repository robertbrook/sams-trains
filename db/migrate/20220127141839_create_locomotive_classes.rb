class CreateLocomotiveClasses < ActiveRecord::Migration[6.1]
  def change
    create_table :locomotive_classes do |t|

      t.timestamps
    end
  end
end
