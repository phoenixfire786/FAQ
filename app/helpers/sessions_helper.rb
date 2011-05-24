module SessionsHelper
  
  def sign_in(employee)
    cookies.permanent.signed[:remember_token] = [employee.id, employee.salt]
    current_employee = employee
  end
  
#  def current_employee=(employee)
#    @current_employee  ||= employee_from_remember_token
#  end

  def current_employee=(employee)
    @current_employee = employee
  end
  
  def current_employee
    @current_employee  ||= employee_from_remember_token
  end
  
  def signed_in?
    !current_employee.nil?
  end
  
  def sign_out
    cookies.delete(:remember_token)
    current_employee = nil
  end
  
  private
  
    def employee_from_remember_token
      Employee.authenticate_with_salt(*remember_token)
    end
    
    def remember_token
      cookies.signed[:remember_token] || [nil, nil]
    end
end
