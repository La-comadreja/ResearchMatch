class Authentication < ActiveRecord::Base

  # === List of columns ===
  #   id         : integer 
  #   user_id    : integer 
  #   provider   : string 
  #   uid        : string 
  #   created_at : datetime 
  #   updated_at : datetime 
  # =======================

  belongs_to :user
end
