class Authorization < ActiveRecord::Base

  # === List of columns ===
  #   id         : integer 
  #   provider   : string 
  #   uid        : string 
  #   user_id    : integer 
  #   token      : string 
  #   secret     : string 
  #   name       : string 
  #   link       : string 
  #   created_at : datetime 
  #   updated_at : datetime 
  # =======================

  belongs_to :user
end
