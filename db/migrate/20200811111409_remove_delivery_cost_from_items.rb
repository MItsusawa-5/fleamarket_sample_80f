class RemoveDeliveryCostFromItems < ActiveRecord::Migration[6.0]
  def change
    remove_column :items, :delivery_cost, :integer
  end
end
