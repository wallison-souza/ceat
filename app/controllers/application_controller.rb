class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :current_user

  def home
    render 'layouts/home'
  end

  def after_sign_in_path_for(resource)
    pacientes_path
  end
  def current_user
    if session["warden.user.usuario.key"].nil? == false
      @current_user = Usuario.find(session["warden.user.usuario.key"][0][0])
    end
  end
  def error_message(obj, nome)
    q_erros = obj.errors.count.to_s
    p_erros = "erro".pluralize(obj.errors.count)
    all_erros = ''
    obj.errors.full_messages.each do |message|
      all_erros = "<li>" + message + "</li>"
    end
    return mensagem =

        "<div class='row'>" +
            "<div class='col-sm-12'>" +
            "<div class='panel panel-danger'>" +
            "<div class='panel-heading panel-heading-message'>" +
            "<h3>" + q_erros +' '+ p_erros + " em " + nome + "</h3>" +
            "<div class='panel-body panel-body-message'>" +
            "<ul class='ul-message'>" + all_erros + "</ul>" +
            "</div></div></div></div></div>"
  end

end
