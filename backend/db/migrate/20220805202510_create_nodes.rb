class CreateNodes < ActiveRecord::Migration[6.0]
  def change
    create_table :nodes do |t|
      t.string :name
      t.references :parent, null: true, foreign_key: { to_table: :nodes }

      t.timestamps
    end
  end
end
