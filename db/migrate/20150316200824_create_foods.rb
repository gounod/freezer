class CreateFoods < ActiveRecord::Migration
  def change
    create_table :foods do |t|
      t.string :title
      t.date :embedded_at
      t.string :product_code
      t.date :best_before
      t.string :location

      t.timestamps null: false
    end
  end
end
