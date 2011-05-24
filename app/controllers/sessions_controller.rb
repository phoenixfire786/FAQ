class SessionsController < ApplicationController

  def new
    @title = "Home"
  end

  def create
    employee = Employee.authenticate(params[:session][:name],params[:session][:password])
    if employee.nil?
      flash.now[:error] = "Invalid email/password combination."
      redirect_to root_path
    else
      sign_in employee
      redirect_to root_path
    end
  end
  
  def destroy
    flash[:notice] = "Testing"
    sign_out
    redirect_to root_path
  end

end
