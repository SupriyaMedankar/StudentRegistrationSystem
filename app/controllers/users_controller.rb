class UsersController < ApplicationController
  before_action :require_admin, only: [:index]
  skip_before_action :authorized, only: [:new, :create]
  before_action :set_user, only: %i[ show edit update destroy ]

  # GET /users or /users.json
  def index
    @users = User.students

    respond_to do |format|
      format.html
      format.csv { send_data generate_csv, filename: "students-#{Date.today}.csv" }
    end
  end

  # GET /users/1 or /users/1.json
  def show

  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users or /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        #send registration email
        # if current user is present send to newly created user
        # else send to admin user
        mail_to = logged_in? ? @user : User.admin.first
        UserMailer.with(user: mail_to).registered.deliver

        redirect_path = current_user.present? ? users_path : root_path
        
        format.html { redirect_to redirect_path, notice: "User was successfully created." }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1 or /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to user_url(@user), notice: "User was successfully updated." }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1 or /users/1.json
  def destroy
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url, notice: "User was successfully destroyed." }
    end
  end

  def import
    return redirect_to request.referer, notice: 'No file added' if params[:file].nil?
    return redirect_to request.referer, notice: 'Only CSV files allowed' unless params[:file].content_type == 'text/csv'

    User.import_from_csv(params[:file])

    redirect_to request.referer, notice: 'User imported successfully'
  end

  def export
    send_data User.generate_csv, filename: "students-#{Date.today}.csv"
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find_by_id(params[:id]) || current_user
  end

  def require_admin
    current_user.is_admin?
  end

  # Only allow a list of trusted parameters through.
  def user_params
    params.require(:user).permit(:name, :dob, :photo, :address, :email, :password, :password_confirmation, :file, :active)
  end
end
