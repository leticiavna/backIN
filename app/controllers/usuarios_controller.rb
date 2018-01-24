class UsuariosController < ApplicationController

  before_action :set_usuario, only: [:show, :edit, :update, :destroy]
  before_action :usuario_nao_logado, except: [:new, :create]
  before_action :usuario_logado, only: [:new, :create]  
  before_action :usuario_correto, only: [:edit, :update]
  before_action :usuario_correto_ou_admin, only: :destroy

  #acoes http: sao public
  #metodos usados apenas pelo controller sao private; nao serao usados em outra coisa

  # GET usuarios/novo
  def new
  	@usuario = Usuario.new
  end

  #POST usuarios/novo
  def create
  	@usuario = Usuario.new(usuario_params)
  	#tomar cuidados com operações no BD
  	if @usuario.save
      flash[:notice] = "Bem vindo à SocialzIN ;)"
      log_in @usuario
  	else
      flash.now[:notice] = "Algo errado aconteceu. :("
  	  render "new"
  	end
  end

  # GET usuarios/1
  def show
  end
  
  # GET usuarios/editar/1
  def edit
  end

  # PATCH usuarios/editar/1
  def update
  	if @usuario.update_attributes(usuario_params)
  		redirect_to show_usuario_path(id: @usuario.id)
  	else
  		render "new"
  	end
  end

  # GET usuarios
  def index
  	@usuarios = Usuario.all
  end


  # DELETE usuarios/1
  def destroy
    #tratar pra ver se vai haver erro no bd
    if @usuario.destroy
    	redirect_to index_usuarios_path
    else
    	show_usuario_path(id: @usuario.id)
    end
  end

  private

  def set_usuario
    #find eh utilizado para encontrar um registro do bd por apenas seu ID (seu parametro) 
    @usuario = Usuario.find(params[:id])
  end
  #este metodo impede que parametros indesejados entre no bs
  #boa pratica de seguranca
  def usuario_params
  	params.require(:usuario).permit(:nome, :sobrenome, :email, :telefone, 
      :data_nascimento, :password, :password_confirmation, :avatar)
  end

  def usuario_correto
    if current_user != @usuario
      flash[:alert] = "Não permitido."
      redirect_to show_usuario_path(id: current_user.id)
    end
  end

  def usuario_correto_ou_admin
    if !current_user.admin && current_user != @usuario
      flash[:alert] = "Não permitido."
      redirect_to show_usuario_path(id: current_user.id)
    elsif current_user == @usuario && current_user.admin
      flash[:alert] = "Não permitido."
      redirect_to show_usuario_path(id: current_user.id)
    end
  end

end
