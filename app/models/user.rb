class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable, :trackable


  private

  def after_confirmation
    WelcomeMailer.send_greeting_notification(self ).deliver_now
  end
end
