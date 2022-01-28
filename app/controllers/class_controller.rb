class ClassController < ApplicationController
  
  def index
    @classes = LocomotiveClass.all.order( 'name' )
  end
  
  def show
    locomotive_class = params[:class]
    @locomotive_class = LocomotiveClass.find( locomotive_class )
  end
end
