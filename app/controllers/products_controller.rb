class ProductsController < ApplicationController
  before_action :product, only: %i[show edit update destroy]

  def index
    @products = Product.all.with_attached_images
  end

  def show; end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      redirect_to products_path, flash: { notice: t("common.created", model: Product.model_name.human) }
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @product.update(product_params)
      redirect_to products_path, flash: { notice: t("common.updated", model: Product.model_name.human)}
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    product.destroy
    redirect_to products_path

    flash[:notice] = t("common.destroyed", model: Product.model_name.human)
  end

  private

  def product_params
    params.require(:product).permit(:name, :description, :price, images: [])
  end

  def product
    @product ||= Product.find(params[:id])
  end
end
