class CatRentalRequestsController < ApplicationController
  before_action :require_cat_owner, only: [:approve, :deny]

  def new
    @cat_rental_request = CatRentalRequest.new
    @cats = Cat.all
  end

  def create
    @cat_rental_request = current_user.cat_rental_requests.new(rental_params)
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
    params.require(:cat_rental_request)
      .permit(:cat_id, :start_date, :end_date)
  end

   def require_cat_owner
     @cat = CatRentalRequest.find(params[:id]).cat
     @owner = @cat.owner

     if @owner.id != current_user.id
       flash[:notices] = "That's not your cat!"
       redirect_to cat_url(@cat)
     end
   end
end
