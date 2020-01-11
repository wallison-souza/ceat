# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20200110014026) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "cidades", force: :cascade do |t|
    t.string   "nome"
    t.integer  "estado_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["estado_id"], name: "index_cidades_on_estado_id", using: :btree
  end

  create_table "estados", force: :cascade do |t|
    t.string   "nome"
    t.string   "sigla"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "pacientes", force: :cascade do |t|
    t.string   "nome"
    t.date     "dt_nasc"
    t.integer  "cidade_id"
    t.string   "rua"
    t.string   "numero"
    t.string   "bairro"
    t.string   "cep"
    t.string   "celular"
    t.string   "telefone"
    t.integer  "sala_id"
    t.string   "profissao"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "sexo"
    t.index ["cidade_id"], name: "index_pacientes_on_cidade_id", using: :btree
    t.index ["sala_id"], name: "index_pacientes_on_sala_id", using: :btree
  end

  create_table "presencas", force: :cascade do |t|
    t.integer  "paciente_id"
    t.integer  "senha"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.boolean  "new_registry"
    t.boolean  "check"
    t.index ["paciente_id"], name: "index_presencas_on_paciente_id", using: :btree
  end

  create_table "salas", force: :cascade do |t|
    t.string   "tipo"
    t.string   "nome"
    t.boolean  "prioridade"
    t.integer  "lista"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "usuarios", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.index ["email"], name: "index_usuarios_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_usuarios_on_reset_password_token", unique: true, using: :btree
  end

  add_foreign_key "cidades", "estados"
  add_foreign_key "pacientes", "cidades"
  add_foreign_key "presencas", "pacientes"
end
