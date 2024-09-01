class ProductsController < ApplicationController
  before_action :product, only: %i[show edit update destroy]

  def index
    @categories = Category.order(name: :asc).load_async
    @products = Product.with_attached_images.order(created_at: :desc).load_async
    if params[:category_id]
      @products = @products.where(category_id: params[:category_id])
    end
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
      redirect_to products_path, flash: { notice: t("common.updated", model: Product.model_name.human) }
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
    params.require(:product).permit(:name, :description, :price, :category_id, images: [])
  end

  def product
    @product ||= Product.find(params[:id])
  end
end
