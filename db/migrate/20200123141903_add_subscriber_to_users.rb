class AddSubscriberToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :subscriber, :boolean, null: false, default: false
  end
end
