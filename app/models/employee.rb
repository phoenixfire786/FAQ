class Employee < ActiveRecord::Base
  attr_accessor :password
  
  validates :password, 
    :presence => true,
    :length => {:within => 6..40}
    
  before_save :encrypt_password
  
  def has_password? (submitted_password)
    encrypted_password == encrypt(submitted_password)
  end
  
  def self.authenticate(name, submitted_password)
    employee = find_by_name(name)
    return nil if employee.nil?
    return employee if employee.has_password?(submitted_password)
  end
  
  def self.authenticate_with_salt(id,cookie_salt)
    employee = find_by_id(id)
    (employee && employee.salt == cookie_salt) ? employee : nil
  end
    
  private
    def encrypt_password
      self.salt = make_salt if new_record?
      self.encrypted_password = encrypt(password)
    end
    
    def encrypt(string)
      secure_hash("#{salt}--#{string}")
    end
    
    def make_salt
      secure_hash("#{Time.now.utc}--#{password}")
    end
    
    def secure_hash(string)
      Digest::SHA2.hexdigest(string)
    end
    
end
