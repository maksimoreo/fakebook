class AddDefaultValueToAcceptedAttributeInFriendship < ActiveRecord::Migration[6.0]
  def up
    change_column_default :friendships, :accepted, false
  end

  def down
    change_column_default :friendships, :accepted, nil
  end
end
