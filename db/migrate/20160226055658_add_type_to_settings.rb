class AddTypeToSettings < ActiveRecord::Migration
  def change
    add_column :settings, :field_type, :string
  end
end
