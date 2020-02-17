class AdminUser < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, 
         :recoverable, :rememberable, :validatable, :registerable
  ADMIN='admin'
  USER='user'
  BANNED='banned'
  ROLES ={ADMIN=>'admin',USER =>'user', BANNED=>'banned' }
end
