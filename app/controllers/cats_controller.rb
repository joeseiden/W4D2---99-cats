class CatsController < ApplicationController
  def index
    @cats = Cat.all
    render :index
  end

  def show
    @cat = Cat.find_by_id(params[:id])
    render :show
  end

  def new
    @cat = Cat.new
    render :new
  end

  def create
    @cat = Cat.new(cat_params)
    if @cat.save
      redirect_to cat_url(@cat)
    else
      render :new
    end
  end

  def update
    @cat = Cat.find(params[:id])
    if @cat.update
      redirect_to edit_cat_url(@cat)
    else
      render :edit
    end
  end

  def edit
    @cat = Cat.find(params[:id])
    render :edit
  end

  private
  def cat_params
    params.require(:cat).permit(:name, :birth_date, :color, :sex, :description)
  end
end
