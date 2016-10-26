class Admin::AccountsController < Admin::BaseController
  before_action :find_account, only: [:destroy, :edit, :update]

  def index
    @accounts = User.all
  end

  def new
    @account = User.new
  end

  def edit
  end

  def update
    if @account.update account_params
      flash[:success] = t "user.update"
    else
      flash[:danger] = t "flash.fail"
    end
    redirect_to admin_accounts_path  
  end

  def create
    @account = User.new account_params
    if @account.save
      flash[:success] = t "account.success"
      redirect_to admin_accounts_path
    else
      render :new
    end   
  end

  def destroy
    if @account.destroy
      flash[:success] = t "account.deteled"
    else
      flash[:danger] = t "flash.fail"
    end
    redirect_to admin_accounts_path     
  end

  private
  
  def account_params
    params.require(:account).permit :name
  end
  
  def find_account
    @account = User.find_by id: params[:id]
    if @account.nil?
      flash[:danger] = t "user.empty"
      redirect_to admin_root_path
    end
  end
end
