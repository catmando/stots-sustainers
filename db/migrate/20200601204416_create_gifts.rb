class CreateGifts < ActiveRecord::Migration[5.2]
  def change
    create_table :gifts do |t|
      t.decimal :amount

      t.timestamps
    end
  end
end
