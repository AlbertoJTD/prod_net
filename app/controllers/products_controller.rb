class ProductsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :handle_record_not_found

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
        flash.now[:success] = t('.success')
        format.html { redirect_to products_path }
        format.turbo_stream
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @product = Product.find(params[:id])
  end

  private

  def handle_record_not_found
    respond_to do |format|
      format.html do
        flash[:alert] = t('products.shared.not_found')
        redirect_to products_path
      end
      format.turbo_stream do
        flash.now[:error] = t('products.shared.not_found')
        render_turbo_stream_flash_messages
      end
    end
  end

  def product_params
    params.require(:product).permit(:name, :description, :visible)
  end
end
