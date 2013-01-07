class UsersController < ApplicationController
  include AttribsHelper
  include CASControllerIncludes
  
  skip_before_filter :verify_authenticity_token, :only => [:auto_complete_for_course_name, 
		:auto_complete_for_category_name, :auto_complete_for_proglang_name]
  auto_complete_for :course, :name
  auto_complete_for :category, :name
  auto_complete_for :proglang, :name
   
  # Ensures that only this user -- and no other users -- can edit his/her profile
  before_filter :correct_user_access, :only => [ :edit, :update, :destroy ]
  
  def show 
    redirect_to :controller => :dashboard, :action => :index unless params[:id].to_s == @current_user.id.to_s
  end

  def create
    # logout_keeping_session!

    # See if this user was already created
    # TODO: handle this better
    if User.exists?(:login=>session[:cas_user].to_s) then
      flash[:error] = "You've already signed up." 
      redirect_to '/'
    end

    @user.update_user_type
    if @user.save && @user.errors.empty? then 
      flash[:notice] = "Thanks for signing up! You're activated so go ahead and sign in."
      redirect_to :controller => "jobs", :action => "index"
           
    else
      logger.error "UsersController.create: Failed because #{@user.errors.inspect}"
      flash[:error]  = "We couldn't set up that account, sorry.  Please try again, or contact support."
      # format.html { render :action => 'new' }
      # redirect_to new_user_path
      redirect_to :controller => "dashboard", :action => "index"
    end
  end
  
  def edit
    @user = User.find(params[:id])
    prepare_attribs_in_params(@user)
  end

  def profile
    @user = @current_user
    prepare_attribs_in_params(@current_user)
    render :edit
  end
  
  def update
    @user = User.find(params[:id])
    
    # If params[:user] is blank? for some reason, instantiate it.
    params[:user] ||= {}
    
    respond_to do |format|
      if @user.update_attributes(params[:user])
        @user.update_attribs(params)
        flash[:notice] = 'User profile was successfully updated.'
        format.html { redirect_to(edit_user_path, :notice => 'User profile was successfully updated.') } 
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  private
	
  def correct_user_access
    if (User.find_by_id(params[:id]) == nil || current_user != User.find_by_id(params[:id]))
      # flash[:error] = "params[:id] is " + params[:id] + "<br />"
      # flash[:error] = "@current_user is " + @current_user + "<br />"
      flash[:error] += "Unauthorized access denied. Do not pass Go. Do not collect $200."
            redirect_to :controller => 'dashboard', :action => :index
    end
  end

end
