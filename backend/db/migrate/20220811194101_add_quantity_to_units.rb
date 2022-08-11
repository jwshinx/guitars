class AddQuantityToUnits < ActiveRecord::Migration[6.0]
  def change
    add_column :units, :quantity, :integer, :default => 0
  end
end
