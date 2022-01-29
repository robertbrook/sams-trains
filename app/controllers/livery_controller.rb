class LiveryController < ApplicationController
  
  def index
    @liveries = Livery.all.order( 'name' )
  end
  
  def show
    livery = params[:livery]
    @livery = Livery.find( livery )
  end
end
