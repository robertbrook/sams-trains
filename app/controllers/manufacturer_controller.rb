class ManufacturerController < ApplicationController
  
  def index
    @manufacturers = Manufacturer.all.order( 'name' )
  end
  
  def show
    manufacturer = params[:manufacturer]
    @manufacturer = Manufacturer.find( manufacturer )
  end
end
