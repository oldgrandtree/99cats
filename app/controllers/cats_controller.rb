class CatsController < ApplicationController

  def index
    @cats = Cat.all
  end

  def create
    @cat = Cat.new(cat_params)

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
end
