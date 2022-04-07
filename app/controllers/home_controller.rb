class HomeController < ApplicationController

  helper_method :formated_date

  def index
  end

  def after_registration_path
    confirmation_pending_path
  end

  private

  def formated_date(date)
    date.strftime('%A, %b %d, %Y')
  end
end
