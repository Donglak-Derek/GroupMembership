class GroupsController < ApplicationController

  def index
  	@groups = Group.all

  end

  def create
  	new_group = Group.create(name: params[:name], desc: params[:desc], user_id: current_user.id)
  	Join.create(user:current_user, group:new_group)
    
  	if new_group.valid?
  		redirect_to :back
  	else
  		redirect_to :back, alert: new_group.errors.full_messages
  	end
  end 

  def joins
  	Join.create(user_id:current_user.id, group_id: params[:id])
  	redirect_to :back
  end

  def show
    #user.id, name clicked add, count group added
  	@group = Group.find_by(id: params[:id])
  	member_ids = Join.where(group_id: params[:id]).all
  	
  	members = []

  	member_ids.each do |member|
	  members << User.find(member.user_id).full_name
	end

	@members = members.uniq

	@joined = false

	if member_ids.exists?(user_id: current_user.id)
		puts @joined = true, "*******************************"
	end
  end

  def add
    this_group = Group.find_by(id: params[:id])
  	Join.create(user: current_user, group: this_group)

    @counts = Join.where(group_id: this_group.id).count
    puts @counts, "*******************************"

  	redirect_to :back
  end

  def destroy
  	group = Group.find(params[:id])
  	group.destroy
  	redirect_to :back
  end

  def leave
  	#params[:id] = group.id
  	joins = Join.where(user_id: current_user.id).where(group_id: params[:id]).all
  	joins.each do |join|
  		join.destroy
  	end
  	group = Group.find(params[:id])
  	if current_user.id == group.user_id
  		group.user_id = nil
  	end

  	puts params[:id], current_user.id, joins, "************************"
  	redirect_to :back
  end
end
