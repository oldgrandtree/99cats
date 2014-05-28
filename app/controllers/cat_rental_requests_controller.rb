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

  def approve
    @rental = CatRentalRequest.find(params[:id])
    @rental.approve!
    redirect_to cat_url(@rental.cat_id)
  end

  def deny
    @rental = CatRentalRequest.find(params[:id])
    @rental.deny!
    redirect_to cat_url(@rental.cat_id)
  end

  private

  def rental_params
    params.require(:cat_rental_request).permit(:cat_id, :start_date, :end_date)
  end
end
