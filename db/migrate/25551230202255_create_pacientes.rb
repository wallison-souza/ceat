class CreatePacientes < ActiveRecord::Migration[5.0]
  def change
    create_table :pacientes do |t|
      t.string :nome
      t.date :dt_nasc
      t.references :cidade, foreign_key: true
      t.string :rua
      t.string :numero
      t.string :bairro
      t.string :cep
      t.string :celular
      t.string :telefone
      t.integer :sexo
      t.references :sala, foreign_key: true
      t.string :profissao

      t.timestamps
    end
  end
end
