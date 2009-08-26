class ActivationsController < ApplicationController
  
  def new
    @user = User.find_using_perishable_token(params[:activation_code], 1.week) || (raise Exception)
    raise Exception if @user.active?
  end
 
  def create
    @user = User.find(params[:id])
 
    raise Exception if @user.active?
 
    if @user.activate!(params)
      @user.deliver_activation_confirmation!
      flash[:notice] = "Your account has been activated."
      redirect_to dashboard_path
    else
      render :action => :new
    end
  end
 
end