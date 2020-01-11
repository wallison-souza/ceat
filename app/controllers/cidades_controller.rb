class CidadesController < ApplicationController

  #fonte: http://argerim.github.io/blog/2012/03/29/preenchendo-combobox-com-cidades-de-acordo-com-o-estado-selecionado-em-rails/
  def cities_by_state
    state_id = params[:id].to_i
    cities = Cidade.where(:estado_id => state_id)
    cty = []
    cities.each do |city|
      cty << {:id => city.id, :n => city.nome}
    end
    render :json => {:cty => cty.compact}.as_json
  end

end
