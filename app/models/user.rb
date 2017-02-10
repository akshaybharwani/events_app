class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable,
         :omniauthable, :omniauth_providers => [:facebook, :google_oauth2]

  has_many :user_provider, :dependent => :destroy
  has_many :events, dependent: :destroy

  protected
  def confirmation_required?
    false
  end
end
