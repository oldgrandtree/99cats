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
  end

  def edit

  end

  def update

  end

  def destroy

  end

  private

  def cat_params
    params[:cat].permit(:name, :age, :birth_date, :sex, :color)
  end
end
