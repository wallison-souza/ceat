class AddSexoToPaciente < ActiveRecord::Migration[5.0]
  def change
    add_column :pacientes, :sexo, :integer
  end
end
