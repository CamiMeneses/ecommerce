class CategoriesController < ApplicationController
  before_action :category, only: %i[ edit update destroy ]

  def index
    @categories = Category.all
  end

  def new
    @category = Category.new
  end

  def edit
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      redirect_to categories_path, flash: { notice: t("common.created", model: Category.model_name.human) }
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @category.update(category_params)
      redirect_to categories_path, flash: { notice: t("common.updated", model: Category.model_name.human) }
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @category.destroy!

    redirect_to categories_url, flash: { notice: t("common.destroyed", model: Category.model_name.human) }
  end

  private
    def category
      @category = Category.find(params[:id])
    end

    def category_params
      params.require(:category).permit(:name)
    end
end
