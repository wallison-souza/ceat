class AddCheckToPresenca < ActiveRecord::Migration[5.0]
  def change
    add_column :presencas, :check, :boolean
  end
end
