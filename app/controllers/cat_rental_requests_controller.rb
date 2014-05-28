class CatRentalRequestsController < ApplicationController
  def new
    @cat_rental_request = CatRentalRequest.new
    @cats = Cat.all
  end

  def create
    @cat_rental_request = CatRentalRequest.new(rental_params)
    @cats = Cat.all

    if @cat_rental_request.save
      redirect_to cat_url(@cat_rental_request.cat_id)
    else
      render :new
    end
  end

  private

  def rental_params
    params[:cat_rental_request].permit(:cat_id, :start_date, :end_date)
  end
end
