class AddNewRegistryToPresenca < ActiveRecord::Migration[5.0]
  def change
    add_column :presencas, :new_registry, :boolean
  end
end
