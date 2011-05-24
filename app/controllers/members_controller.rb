class MembersController < ApplicationController
  def sign_in
    @all_members = Member.find(:all)
    @waiting_members = Member.find(:all, :conditions => {:seen_time => nil})
    @seen_members = Member.find(:all, :conditions => ["out_time IS ? and seen_time IS NOT ?", nil, nil])
    @member = Member.new
    @title = "Sign In"
  end

  def create
    unless params[:member][:id].nil?
      if  Member.find(params[:member][:id]).seen_time.nil?
        Member.find(params[:member][:id]).update_attributes(:seen_time => Time.now, :msr => current_employee.name)
        redirect_to root_path
        return
      else
        Member.find(params[:member][:id]).update_attributes(:out_time => Time.now)
        redirect_to root_path
        return
      end
    end

    @member = Member.new(params[:member])
    if @member.save
      redirect_to root_path
    else
      redirect_to root_path
    end
  end

end