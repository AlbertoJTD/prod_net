require 'rails_helper'

RSpec.describe "Votes", type: :request do
  let(:product) { create(:product) }
  let(:comment) { create(:comment) }

  describe 'POST /create' do
    context 'when votable is a Product' do
      it 'assigns the votable to @votable' do
        post product_votes_path(product), params: { votable_id: product.id, votable_type: product.class.name }
        expect(assigns(:votable)).to eq(product)
      end

      it 'creates a new vote' do
        expect {
          post product_votes_path(product), params: { votable_id: product.id, votable_type: product.class.name }
        }.to change(Vote, :count).by(1)
      end
    end

    context 'when votable is a Comment' do
      it 'assigns the votable to @votable' do
        post product_comment_votes_path(product, comment), params: { votable_id: comment.id, votable_type: comment.class.name }
        expect(assigns(:votable)).to eq(comment)
      end

      it 'creates a new vote' do
        expect {
          post product_comment_votes_path(product, comment), params: { votable_id: comment.id, votable_type: comment.class.name }
        }.to change(Vote, :count).by(1)
      end
    end
  end
end
