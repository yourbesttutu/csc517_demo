class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy,:showmethod]
  before_action :require_login , except: [:regist,:create]
  include SessionsHelper
  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @ture=1
    @user = User.new(user_params)
    @users = User.all
    @users.each do |x|
      if (x.email==@user.email)
        redirect_to new_user_url, notice: 'email is taken'
        @ture=0
        break
      end
    end
    if(@ture==1)
      if logged_in?
        @user.permission=1
      else
        @user.permission=2
      end
      if logged_in?
    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
      else
        respond_to do |format|
          if @user.save
            format.html { redirect_to login_path, notice: 'User was successfully created.' }
            format.json { render :show, status: :created, location: @user }
          else
            format.html { render :new }
            format.json { render json: @user.errors, status: :unprocessable_entity }
          end
          end
    end
      end
  end

  def regist
    @user = User.new
   end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:name,:email,:password)
    end
  def require_login
    unless logged_in?
      redirect_to login_url, notice: 'login first plz'# halts request cycle
    end
  end
end
