class ProductsController < ApplicationController
  before_action :product, only: %i[show edit update destroy]

  def index
    @products = Product.all
  end

  def show; end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      redirect_to products_path, flash: { notice: "Product was successfully created." }
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @product.update(product_params)
      redirect_to products_path, flash: { notice: "Product was successfully updated." }
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    product.destroy
    redirect_to products_path

    flash[:notice] = "Product was successfully deleted."
  end

  private

  def product_params
    params.require(:product).permit(:name, :description, :price)
  end

  def product
    @product ||= Product.find(params[:id])
  end
end
