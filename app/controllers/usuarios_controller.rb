class UsuariosController < ApplicationController

  before_action :usuario_nao_logado, except: :index

  # GET usuarios/novo
  def new
  	@usuario = Usuario.new
  end

  #POST usuarios/novo
  def create
  	@usuario = Usuario.new(usuario_params)
  	#tomar cuidados com operações no BD
  	if @usuario.save
  	  redirect_to index_usuarios_path
  	else
  	  render "new"
  	end
  end

  # GET usuarios/1
  def show
  	#find eh utilizado para encontrar um registro do bd por apenas seu ID (seu parametro) 
  	@usuario = Usuario.find(params[:id])
  end
  
  # GET usuarios/editar/1
  def edit
  	@usuario = Usuario.find(params[:id])
  end

  # PATCH usuarios/editar/1
  def update
  	@usuario = Usuario.find(params[:id])
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
    @usuario = Usuario.find(params[:id])
    #tratar pra ver se vai haver erro no bd
    if @usuario.destroy
    	redirect_to index_usuarios_path
    else
    	show_usuario_path(id: @usuario.id)
    end
  end

  private

  #este metodo impede que parametros indesejados entre no bs
  #boa pratica de seguranca
  def usuario_params
  	params.require(:usuario).permit(:nome, :sobrenome, :email, :telefone, 
      :data_nascimento, :password, :password_confirmation)
  end
end
