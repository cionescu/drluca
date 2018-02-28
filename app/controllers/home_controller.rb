class HomeController < ApplicationController
  def index
    render :index, layout: "static"
  end
end
