class CommentsController < ApplicationController
  before_action :set_comment, only: %i[edit update destroy]
  before_action :set_comentable, only: %i[create]
  rescue_from ActiveRecord::RecordNotFound, with: :handle_record_not_found

  def create
    @comment = @comentable.comments.new(comment_params)
    @comment.save

    respond_to do |format|
      format.html { redirect_to redirect_path_for(@comentable), notice: t('.success') }
      format.turbo_stream
    end
  end

  def edit; end

  def update; end

  def destroy
    @comentable = @comment.comentable
    @comment.destroy

    respond_to do |format|
      flash.now[:success] = t('.success')
      format.html { redirect_to redirect_path_for(@comentable), notice: t('.success') }
      format.turbo_stream
    end
  end

  private

  def handle_record_not_found
    respond_to do |format|
      format.html do
        flash[:alert] = t('comments.not_found')
        redirect_to products_path
      end
      format.turbo_stream do
        flash.now[:error] = t('comments.not_found')
        render_turbo_stream_flash_messages
      end
    end
  end

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def set_comentable
    @comentable = params.dig(:comment, :comentable_type).safe_constantize.find_by(id: params.dig(:comment, :comentable_id))
  end

  def redirect_path_for(comentable)
    case comentable
    when Product
      product_path(@comentable)
    when Category
      category_path(@comentable)
    else
      root_path
    end
  end

  def comment_params
    params.require(:comment).permit(:message, :comentable_id, :comentable_type)
  end
end
