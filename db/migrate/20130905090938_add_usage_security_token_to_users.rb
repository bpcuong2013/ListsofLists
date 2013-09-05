class AddUsageSecurityTokenToUsers < ActiveRecord::Migration
  def change
    add_column :users, :usage_security_token, :string
  end
end
