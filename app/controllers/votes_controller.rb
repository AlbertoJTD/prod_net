class VotesController < ApplicationController
  before_action :set_votable, only: %i[create]

  def create
    @vote = @votable.votes.new
    @vote.save

    respond_to do |format|
      format.html { redirect_to @votable }
      format.turbo_stream
    end
  end

  def destroy
    @vote.destroy

    respond_to do |format|
      format.turbo_stream { render turbo_stream: turbo_stream.remove(@vote) }
      format.html { redirect_to @vote }
    end
  end

  private

  def set_votable
    @votable = params[:votable_type]&.safe_constantize&.find_by(id: params[:votable_id])
  end

  def set_vote
    @vote ||= Vote.find(params[:id])
  end

  def vote_params
    params.require(:vote).permit(:votable_id, :votable_type)
  end
end
