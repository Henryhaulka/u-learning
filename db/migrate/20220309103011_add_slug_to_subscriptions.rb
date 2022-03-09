class AddSlugToSubscriptions < ActiveRecord::Migration[6.1]
  def change
    add_column :subscriptions, :slug, :string
    add_index :subscriptions, :slug, unique: true
  end
end
