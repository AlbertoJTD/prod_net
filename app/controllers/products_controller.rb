class ProductsController < ApplicationController
  def index
    @products = Product.all.where(visible: true).order(id: :desc)
  end

  private

  def product_params
    params.require(:product).permit(:name, :description, :visible)
  end
end
