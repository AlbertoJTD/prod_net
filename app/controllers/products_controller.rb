class ProductsController < ApplicationController
  def index
    @products = Product.all.where(visible: true).order(id: :desc)
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)

    if @product.save
      respond_to do |format|
        format.html { redirect_to products_path, notice: t('.success') }
        format.turbo_stream
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def product_params
    params.require(:product).permit(:name, :description, :visible)
  end
end
