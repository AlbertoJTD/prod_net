class CommentsController < ApplicationController
  before_action :set_comment, only: %i[edit update destroy]
  rescue_from ActiveRecord::RecordNotFound, with: :handle_record_not_found

  def edit; end

  def update; end

  def destroy
    @comentable = @comment.comentable
    @comment.destroy

    respond_to do |format|
      flash.now[:success] = t('.success')
      format.html { redirect_to products_path }
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
end
