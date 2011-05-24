class Member < ActiveRecord::Base
	attr_accessible :name, :reason, :seen_time, :msr, :out_time

	validates :name, 
    :length => { :within => 1..40}
  
  validates :reason,
    :presence => true	
  
  def assign_msr(selected_name, msr_name)
    member = Member.find_by_name(selected_name)
    member.update_attributes(:msr => msr_name) unless member.nil?
  end
   
end
