class Presenca < ApplicationRecord
  belongs_to :paciente

  #Filtro e Live Search
  filterrific(
      default_filter_params: { sorted_by: 'nome_asc' },
      available_filters: [
          :sorted_by,
          :search_query
      ]
  )
  #Escopos para o filterrific
  scope :search_query, lambda { |query|
    if query.blank?
      order('pacientes.nome ASC')
    else
      where('upper(pacientes.nome) like upper(?)', "%#{query}%").order('pacientes.nome ASC')
    end
  }

  scope :sorted_by, lambda { |sort_option|
    direction = (sort_option =~ /desc$/) ? 'desc' : 'asc'
    order("pacientes.nome #{direction}")
  }

  def self.today
    where("presencas.created_at >= ?", Time.zone.now.beginning_of_day).where('new_registry is not true').order(:senha)
  end

  def self.today_new
    where("presencas.created_at >= ?", Time.zone.now.beginning_of_day).where(new_registry: true).order(:senha)
  end


end
