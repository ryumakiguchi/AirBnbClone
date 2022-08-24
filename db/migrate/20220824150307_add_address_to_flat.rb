class AddAddressToFlat < ActiveRecord::Migration[7.0]
  def change
    add_column :flats, :address, :string
  end
end
