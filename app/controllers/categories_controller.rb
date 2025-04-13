class CategoriesController < ApplicationController
  before_action :set_category, only: %i[ show edit update destroy ]
  rescue_from ActiveRecord::RecordNotFound, with: :handle_record_not_found

  # GET /categories or /categories.json
  def index
    @pagy, @categories = pagy_countless(Category.all, limit: 15)
  end

  # GET /categories/1 or /categories/1.json
  def show
  end

  # GET /categories/new
  def new
    @category = Category.new
  end

  # GET /categories/1/edit
  def edit
  end

  # POST /categories or /categories.json
  def create
    @category = Category.new(category_params)

    if @category.save
      respond_to do |format|
        flash.now[:success] = t('.success')
        format.html { redirect_to categories_path, success: t('.success') }
        format.turbo_stream
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /categories/1 or /categories/1.json
  def update
    if @category.update(category_params)
      respond_to do |format|
        flash.now[:success] = t('.success')
        format.html { redirect_to categories_path, success: t('.success') }
        format.turbo_stream
      end
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /categories/1 or /categories/1.json
  def destroy
    @category.destroy!

    respond_to do |format|
      flash.now[:success] = t('.success')
      format.html { redirect_to categories_path, success: t('.success') }
      format.turbo_stream
    end
  end

  private

  def handle_record_not_found
    respond_to do |format|
      format.html { redirect_to categories_path, status: :see_other, alert: t('categories.not_found') }
      format.json { head :no_content }
    end
  end

  def set_category
    @category = Category.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:name)
  end
end
