class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def filter
    if params[:query].blank?
      @animal = Animal.all
    else
      field = params[:field]
      query = "%#{params[:query]}%"
      @animal = Animal.where("#{field} LIKE ?", query)
    end
  end
end
  #include SessionsHelper
#end
