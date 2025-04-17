require 'rails_helper'

RSpec.describe "Comments", type: :request do
  let(:comment) { create(:comment) }

  describe 'DELETE /destroy' do
    context 'request as html' do
      it 'returns http success' do
        delete comment_path(comment)
        expect(response).to have_http_status(:redirect)
      end

      it 'redirects to the product' do
        delete comment_path(comment)
        expect(response).to redirect_to(product_path(comment.comentable))
      end

      it 'should decrease the comment count' do
        comment = create(:comment)

        expect {
          delete comment_path(comment)
        }.to change(Comment, :count).by(-1)
      end
    end

    context 'request as turbo_stream' do
      it 'assings the comment to @comment' do
        delete comment_path(comment), as: :turbo_stream
        expect(assigns(:comment)).to eq(comment)
      end

      it "returns http success" do
        delete comment_path(comment), as: :turbo_stream
        expect(response).to have_http_status(:success)
      end
    end
  end
end
