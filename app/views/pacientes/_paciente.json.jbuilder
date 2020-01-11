json.extract! paciente, :id, :nome, :dt_nasc, :cidade_id, :rua, :numero, :bairro, :cep, :celular, :telefone, :sala_id, :profissao, :created_at, :updated_at
json.url paciente_url(paciente, format: :json)
