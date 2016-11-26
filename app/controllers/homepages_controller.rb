class HomepagesController < ApplicationController
  def index
    @courses = Course.all
  end
end
