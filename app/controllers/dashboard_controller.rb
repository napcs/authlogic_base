class DashboardController < ApplicationController
  
  before_filter :require_user

  
  def show
    @user = current_user
  end
  
end
