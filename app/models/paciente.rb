class Paciente < ApplicationRecord
  belongs_to :cidade, optional: true
  belongs_to :sala, optional: true
  has_many :presencas, dependent: :delete_all

  enum sexo: {'Masculino':1, 'Feminino':2}

  #Filtro e Live Search
  filterrific(
      default_filter_params: { sorted_by: 'nome_asc' },
      available_filters: [
          :sorted_by,
          :search_query
      ]
  )

  def self.is_number? string
    true if Integer(string) rescue false
  end

  #Escopos para o filterrific
  scope :search_query, lambda { |query|
    if query.blank?
      order('nome ASC')
    else
      if is_number? query
        where('id = ?', query).order('nome ASC')

      else
        where('upper(nome) like upper(?)', "%#{query}%").order('nome ASC')
      end
    end
  }

  scope :sorted_by, lambda { |sort_option|
    direction = (sort_option =~ /desc$/) ? 'desc' : 'asc'
    order("nome #{direction}")
  }
  def self.not_today
    where("pacientes.created_at < ?", Time.zone.now.beginning_of_day).order(:nome)
  end




end
