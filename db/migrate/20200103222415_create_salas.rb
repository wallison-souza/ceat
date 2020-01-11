class CreateSalas < ActiveRecord::Migration[5.0]
  def change
    create_table :salas do |t|
      t.string :tipo
      t.string :nome
      t.boolean :prioridade
      t.integer :lista

      t.timestamps
    end
  end
end
