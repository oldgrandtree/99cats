class CatsController < ApplicationController

  before_action :require_cat_owner, only: [:edit, :update, :destroy]
  before_action :require_signed_in, only: [:new]

  def index
    @cats = Cat.all
  end

  def create
    @cat = current_user.cats.new(cat_params)

    if @cat.save
      redirect_to cat_url(@cat)
    else
      render :new
    end
  end

  def new
    @cat = Cat.new
  end

  def show
    @cat = Cat.find(params[:id])
    @rentals = CatRentalRequest.where(cat_id: @cat.id).order(:start_date)
  end

  def edit
    @cat = Cat.find(params[:id])
  end

  def update
    @cat = Cat.find(params[:id])

    if @cat.update(cat_params)
      redirect_to cat_url(@cat)
    else
      render :edit
    end
  end

  def destroy
    @cat = Cat.find(params[:id]).destroy

    redirect_to cats_url
  end

  private

  def cat_params
    params.require(:cat).permit(:name, :age, :birth_date, :sex, :color)
  end

  def require_cat_owner
    @cat = Cat.find(params[:id])
    if User.find(@cat.user_id) != current_user
      flash[:notices] = "That's not your cat!"
      redirect_to cat_url(@cat)
    end
  end

end
