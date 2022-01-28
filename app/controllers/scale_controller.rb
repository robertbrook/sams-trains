class ScaleController < ApplicationController
  
  def index
    @scales = Scale.all.order( 'name' )
  end
  
  def show
    scale = params[:scale]
    @scale = Scale.find( scale )
  end
end
