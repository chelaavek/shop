class AdminUser < ApplicationRecord
  acts_as_google_authenticated :lookup_token => :mfa_secret,
                               :encrypt_secrets => true
  after_create {|record| record.set_google_secret }
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  delegate :can?, :cannot?, :to => :ability
  devise :database_authenticatable, 
         :recoverable, :rememberable, :validatable, :registerable, :confirmable
  ADMIN='admin'
  USER='user'
  BANNED='banned'
  ROLES ={ADMIN=>'admin',USER =>'user', BANNED=>'banned' }

  def ability
    @ability ||= Ability.new(self)
  end
end
