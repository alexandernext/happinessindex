class HomeController < ApplicationController

  def index
    if user_signed_in?
      redirect_to scores_path
    end
  end
end
