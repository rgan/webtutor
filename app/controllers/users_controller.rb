class UsersController < ApplicationController

 layout "main"
   
 before_filter :authorize_for_admin, :except => [:new, :create]
 
 def new
   @user = User.new
 end
 
 def create
   @user = User.new(params[:user])
   @user.roles << Role.find_by_name(Role::STUDENT)
   
   respond_to do |format|
     if @user.save
       session[:user_id] = @user.id
       session[:user_name] = @user.name
       flash[:notice] = 'User successfully created!'
       format.html { redirect_to root_path }
     else
       format.html { render :action => :new }
     end
   end
 end
 
 def assign_role
   @roles = Role::ALL_ROLES - @user.roles
   if @user && request.post?
     puts @user.name
     @user.roles << Role.find_by_id(params[:user_role][:role_id])
   end
 end
 
 end