class ContactUsController < ApplicationController
  def contact
    if user_signed_in?
      @user_email = @current_user.email
    else
      flash[:notice] = "You must be logged in to leave feedback"
      redirect_back_or home_path
    end
  end

  def contact_wo_login
  end
  
  def send_email
    sender = params[:sender]
    subject = params[:subject]
    body = params[:body]
    mail = FeedbackMailer.send_feedback(sender, subject, body)
    mail.deliver
    flash[:notice] = "Your message has been sent. Thanks for your feedback!"
    
    if user_signed_in?
      redirect_to dashboard_path
    else
      redirect_to home_path
    end
  end
end
