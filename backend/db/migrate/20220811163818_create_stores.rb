class CreateStores < ActiveRecord::Migration[6.0]
  def change
    create_table :stores do |t|
      t.string :name
      t.boolean :active

      t.timestamps
    end
  end
end
