class CreatePresencas < ActiveRecord::Migration[5.0]
  def change
    create_table :presencas do |t|
      t.references :paciente, foreign_key: true
      t.integer :senha
      t.boolean  :new_registry
      t.boolean  :check

      t.timestamps
    end
  end
end
