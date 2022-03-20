class HomeController < ApplicationController
  def index
  end

  def after_registration_path
    confirmation_pending_path
  end
end
