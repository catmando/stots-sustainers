class UpdateGiftAndCampaign < ActiveRecord::Migration[5.2]
  def change
    add_column :gifts, :one_time, :boolean, null: false, default: false
    add_column :gifts, :transaction_id, :string
  end
end
