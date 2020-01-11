class PresencasController < ApplicationController
  before_action :set_presenca, only: [:show, :edit, :update, :destroy]

  # GET /presencas
  # GET /presencas.json
  def index
    @presencas = Presenca.all
  end



  def lists_normals
    @filterrific_blue = initialize_filterrific(
        Presenca.today.joins(:paciente => :sala).where(pacientes:{salas:{lista: 2}}),
        params[:filterrific],
        default_filter_params: {sorted_by: 'nome_asc'},
        available_filters: [:search_query],
        ) or return

    @blue = @filterrific_blue.find.page(params[:page])

    @filterrific_red = initialize_filterrific(
        Presenca.today.joins(:paciente => :sala).where(pacientes:{salas:{lista: 1}}),
        params[:filterrific],
        default_filter_params: {sorted_by: 'nome_asc'},
        available_filters: [:search_query],
        ) or return

    @red = @filterrific_red.find.page(params[:page])

    respond_to do |format|
      format.html
      format.js
    end


  rescue ActiveRecord::RecordNotFound => e
    puts "Had to reset filterrific params: #{ e.message}"
    redirect_to(reset_filterrific_url(format: :html)) and return
  end

  def list_blue
    @filterrific_blue = initialize_filterrific(
        Presenca.today.joins(:paciente => :sala).where(pacientes:{salas:{lista: 2}}),
        params[:filterrific],
        default_filter_params: {sorted_by: 'nome_asc'},
        available_filters: [:search_query],
        ) or return

    @blue = @filterrific_blue.find.page(params[:page])
    respond_to do |format|
      format.html
      format.js
    end


  rescue ActiveRecord::RecordNotFound => e
    puts "Had to reset filterrific params: #{ e.message}"
    redirect_to(reset_filterrific_url(format: :html)) and return
  end

  def list_red

    @filterrific_red = initialize_filterrific(
        Presenca.today.joins(:paciente => :sala).where(pacientes:{salas:{lista: 1}}),
        params[:filterrific],
        default_filter_params: {sorted_by: 'nome_asc'},
        available_filters: [:search_query],
        ) or return

    @red = @filterrific_red.find.page(params[:page])
    respond_to do |format|
      format.html
      format.js
    end


  rescue ActiveRecord::RecordNotFound => e
    puts "Had to reset filterrific params: #{ e.message}"
    redirect_to(reset_filterrific_url(format: :html)) and return

  end


  def lists_priority
    @filterrific_first = initialize_filterrific(
       Presenca.today_new.joins(:paciente),
        params[:filterrific],
        default_filter_params: {sorted_by: 'nome_asc'},
        available_filters: [:search_query],
        ) or return

    @first_time = @filterrific_first.find.page(params[:page])


    @filterrific_priority = initialize_filterrific(
        Presenca.today.joins(:paciente => :sala).where(pacientes:{salas:{prioridade: true}}),
        params[:filterrific],
        default_filter_params: {sorted_by: 'nome_asc'},
        available_filters: [:search_query],
        ) or return

    @priority = @filterrific_priority.find.page(params[:page])

    respond_to do |format|
      format.html
      format.js
    end


  rescue ActiveRecord::RecordNotFound => e
    puts "Had to reset filterrific params: #{ e.message}"
    redirect_to(reset_filterrific_url(format: :html)) and return
  end

  def list_first_time
    @filterrific_first = initialize_filterrific(
       Presenca.today_new.joins(:paciente),
        params[:filterrific],
        default_filter_params: {sorted_by: 'nome_asc'},
        available_filters: [:search_query],
        ) or return

    @first_time = @filterrific_first.find.page(params[:page])
    respond_to do |format|
      format.html
      format.js
    end


  rescue ActiveRecord::RecordNotFound => e
    puts "Had to reset filterrific params: #{ e.message}"
    redirect_to(reset_filterrific_url(format: :html)) and return

  end


  def list_priority
    @filterrific_priority = initialize_filterrific(
        Presenca.today.joins(:paciente => :sala).where(pacientes:{salas:{prioridade: true}}),
        params[:filterrific],
        default_filter_params: {sorted_by: 'nome_asc'},
        available_filters: [:search_query],
        ) or return

    @priority = @filterrific_priority.find.page(params[:page])
    respond_to do |format|
      format.html
      format.js
    end


  rescue ActiveRecord::RecordNotFound => e
    puts "Had to reset filterrific params: #{ e.message}"
    redirect_to(reset_filterrific_url(format: :html)) and return

  end

  def pacientes
    @filterrific = initialize_filterrific(
        Paciente.not_today,
        params[:filterrific],
        default_filter_params: {sorted_by: 'nome_asc'},
        available_filters: [:search_query],
        ) or return

    @search = @filterrific.find.page(params[:paciente_page])

    respond_to do |format|
      format.html
      format.js
    end


    rescue ActiveRecord::RecordNotFound => e
      puts "Had to reset filterrific params: #{ e.message}"
      redirect_to(reset_filterrific_url(format: :html)) and return

  end



  # GET /presencas/new
  def new
    @filterrific = initialize_filterrific(
        Paciente.not_today,
        params[:filterrific],
        default_filter_params: {sorted_by: 'nome_asc'},
        available_filters: [:search_query],
        ) or return

    @search = @filterrific.find.page(params[:paciente_page])
    @presencas = Presenca.today.page(params[:page])
    @presenca = Presenca.new

  end


  # GET /presencas/1/edit
  def edit
  end

  # POST /presencas
  # POST /presencas.json
  def create
    @presenca = Presenca.new(presenca_params)

    respond_to do |format|
      if @presenca.save
        if Paciente.find(presenca_params[:paciente_id]).update(sala_id: params[:sala])
          @presencas = Presenca.today.page(params[:page])
          format.html {render partial: 'list', locals:{presencas: @presencas, action: 'senhas'}, status: :ok}
        else
          format.html { render plain: error_message(@presenca, 'Presencas'),  status: :unprocessable_entity }
        end
      else
        format.html { render plain: error_message(@presenca, 'Presencas'),  status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /presencas/1
  # PATCH/PUT /presencas/1.json
  def update
    respond_to do |format|
      if @presenca.update(presenca_params)
        format.html { redirect_to @presenca, flash:{success: "Presenca foi atualizada com sucesso." } }
        format.json { render :show, status: :ok, location: @presenca }
      else
        format.html { render :edit }
        format.json { render json: @presenca.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /presencas/1
  # DELETE /presencas/1.json
  def destroy
    @presenca.destroy
    respond_to do |format|
      @presencas = Presenca.today.page(params[:page])
      format.html {render partial: 'list', locals:{presencas: @presencas, action:'senhas'}, status: :ok}
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_presenca
      @presenca = Presenca.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def presenca_params
      params.require(:presenca).permit(:paciente_id, :senha, :check)
    end
end
