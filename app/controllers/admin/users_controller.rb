class Admin::UsersController < ApplicationController
  before_filter :require_user
  before_filter :admin_only
  before_filter :find_user, :except =>[:index, :new, :create]
  
  def index
    @users = User.active( :order => "created_at desc" )
    respond_to do |format|
      format.html
      format.xml {render :xml=>@users.to_xml}
    end
  end
  
  def show
    respond_to do |format|
      format.html
      format.xml {render :xml=>@user.to_xml}
    end
  end
  
  def new
    @user = User.new
  end
  
  
  def make_admin
    @user.make_admin
    redirect_to admin_users_path
  end
  
  def remove_admin
    @user.remove_admin
    redirect_to admin_users_path
  end
  
  def create
    @user = User.new(params[:user])
    @user.active = true
    if @user.save
      flash[:notice] = "The account has been created and activated."
      redirect_to admin_users_url
    else
      render :action => :new
    end
  end
  
  def edit
    render :action => "edit"
  end
  
  def update
    if @user.update_attributes(params[:user])
        flash[:notice] = "The account has been updated."
        redirect_to admin_users_path
    else
      render :action => "edit"
    end
  end
  
  private
  def find_user
    @user = User.find(params[:id])
  end
  
end
