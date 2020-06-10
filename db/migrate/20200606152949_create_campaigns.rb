class CreateCampaigns < ActiveRecord::Migration[5.2]
  def change
    create_table :campaigns do |t|
      t.string   :name
      t.decimal  :goal, default: 12_000
      t.text     :greeting
      t.string   :slug
      t.string   :sustainer_form_id
      t.string   :one_time_form_id

      t.timestamps
    end
    add_column :gifts, :campaign_id, :integer
  end
end
