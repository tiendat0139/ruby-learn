class PagesController < ApplicationController
  # one function in controller ~ one file in views
  def home
    redirect_to articles_path if logged_in?
  end

  def about

  end
end
