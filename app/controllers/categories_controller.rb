class CategoriesController < ApplicationController
  layout "admin"

  def index
    @categories = Category.all
  end

  def new
    @label_id = "N/A"
    @category = Category.new
  end

  def create
    @category = Category.new( whitelisted_params )
    if @category.save
      redirect_to categories_path, notice: "Category Created"
    else
      flash.now[:alert] = "Failed to Create Category."
      render :new
    end
  end

  def update
    @category = Category.find( params[:id] )
    if @category.update(whitelisted_params)
      redirect_to categories_path, notice: "Category Updated!"
    else
      flash.now[:alert] = "Failed to Edit Category."
      render :edit
    end
  end

  def show
    @category = Category.find( params[:id] )
    @products =  @category.products
  end

  def edit
    @category = Category.find( params[:id] )
    @label_id = @category.id
    render :new
  end

  def delete
    @category = Category.find( params[:id] )
  end

  def destroy
    @category = Category.find( params[:id] )
    if @category.destroy
      redirect_to categories_path, notice: "Category Deleted!"
    else
      redirect_to :back, alert: "Failed to Delete Category."
    end
  end

  private
  def whitelisted_params
    params.require(:category).permit(:name)
  end

end
