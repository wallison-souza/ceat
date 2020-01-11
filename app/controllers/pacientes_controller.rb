class PacientesController < ApplicationController
  before_action :set_paciente, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_usuario!

  # GET /pacientes
  # GET /pacientes.json
  def index
    @filterrific = initialize_filterrific(
        Paciente,
        params[:filterrific],
        default_filter_params: {sorted_by: 'nome_asc'},
        available_filters: [:search_query],
        ) or return

    @pacientes = @filterrific.find.page(params[:page])

    respond_to do |format|
      format.html
      format.js
    end


  rescue ActiveRecord::RecordNotFound => e
    puts "Had to reset filterrific params: #{ e.message}"
    redirect_to(reset_filterrific_url(format: :html)) and return

  end

  # GET /pacientes/1
  # GET /pacientes/1.json
  def show
  end

  # GET /pacientes/new
  def new
    @paciente = Paciente.new
  end

  # GET /pacientes/1/edit
  def edit
  end

  # POST /pacientes
  # POST /pacientes.json
  def create
    @paciente = Paciente.new(paciente_params)

    respond_to do |format|
      if @paciente.save
        if Presenca.create(paciente_id: @paciente.id, senha: params[:senha], new_registry: true)
          format.html { redirect_to @paciente,  flash:{success: "Paciente foi criado com sucesso." } }
          format.json { render :show, status: :created, location: @paciente }
        end
      else
        format.html { render :new }
        format.json { render json: @paciente.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pacientes/1
  # PATCH/PUT /pacientes/1.json
  def update
    respond_to do |format|
      if @paciente.update(paciente_params)
        format.html { redirect_to @paciente,  flash:{success: "Paciente foi atualizado com sucesso." }}
        format.json { render :show, status: :ok, location: @paciente }
      else
        format.html { render :edit }
        format.json { render json: @paciente.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pacientes/1
  # DELETE /pacientes/1.json
  def destroy
    @paciente.destroy
    respond_to do |format|
      format.html { redirect_to pacientes_url, flash:{success: "Paciente foi apagado com sucesso." }}
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_paciente
      @paciente = Paciente.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def paciente_params
      params.require(:paciente).permit(:nome, :dt_nasc, :cidade_id, :rua, :numero, :bairro, :cep, :celular, :telefone, :sala_id, :profissao, :sexo)
    end
end
