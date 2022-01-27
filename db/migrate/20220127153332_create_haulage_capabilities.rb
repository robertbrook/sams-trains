class CreateHaulageCapabilities < ActiveRecord::Migration[6.1]
  def change
    create_table :haulage_capabilities do |t|

      t.timestamps
    end
  end
end
