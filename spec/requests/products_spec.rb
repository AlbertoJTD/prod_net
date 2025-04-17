require 'rails_helper'

RSpec.describe "Products", type: :request do
  let(:valid_attributes) { { name: 'Test Product', description: 'Test Description', visible: true } }
  let(:invalid_attributes) { { name: '', description: 'Test Description', visible: true } }

  describe 'GET /index' do
    it 'returns http success' do
      get '/products'
      expect(response).to have_http_status(:success)
    end

    it 'assigns visible products to @products' do
      visible_product = create(:product, visible: true)
      hidden_product = create(:product, visible: false)

      get '/products'
      expect(assigns(:products)).to include(visible_product)
      expect(assigns(:products)).not_to include(hidden_product)
    end

    it 'orders products by popularity' do
      product1 = create(:product)
      product2 = create(:product)
      product3 = create(:product)

      # Create votes for the products
      create_list(:vote, 3, votable: product2)  # product2 has 3 votes
      create_list(:vote, 1, votable: product1)  # product1 has 1 vote

      get products_path

      # Products should be ordered by vote count in descending order
      expect(assigns(:products).first).to eq(product2)  # Most votes
      expect(assigns(:products).second).to eq(product1) # Second most votes
      expect(assigns(:products).last).to eq(product3)   # Least votes
    end
  end

  describe 'GET /new' do
    it 'returns http success' do
      get '/products/new'
      expect(response).to have_http_status(:success)
    end

    it 'assigns a new product to @product' do
      get '/products/new'
      expect(assigns(:product)).to be_a_new(Product)
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      it 'creates a new Product' do
        expect {
          post products_path, params: { product: valid_attributes }
        }.to change(Product, :count).by(1)
      end

      it 'redirects to the products list with HTML format' do
        post products_path, params: { product: valid_attributes }
        expect(response).to redirect_to(products_path)
      end

      it 'sets a success notice' do
        post products_path, params: { product: valid_attributes }
        expect(flash[:success]).to eq(I18n.t('products.create.success'))
      end

      it 'responds with turbo stream format' do
        post products_path, params: { product: valid_attributes }, as: :turbo_stream
        expect(response.media_type).to eq Mime[:turbo_stream]
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new Product' do
        expect {
          post products_path, params: { product: invalid_attributes }
        }.to change(Product, :count).by(0)
      end

      it 'renders the new template with unprocessable_entity status' do
        post products_path, params: { product: invalid_attributes }
        expect(response).to render_template(:new)
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'GET /show' do
    it 'returns http success' do
      product = create(:product)

      get product_path(product)
      expect(response).to have_http_status(:success)
    end

    it 'assigns the product to @product' do
      product = create(:product)

      get product_path(product)
      expect(assigns(:product)).to eq(product)
    end

    context 'when the product is not found' do
      it 'redirects to the products list' do
        get product_path(999)
        expect(response).to redirect_to(products_path)
      end
    end
  end

  describe 'GET /edit' do
    it 'returns http success' do
      product = create(:product)

      get edit_product_path(product)
      expect(response).to have_http_status(:success)
    end

    it 'assigns the product to @product' do
      product = create(:product)

      get edit_product_path(product)
      expect(assigns(:product)).to eq(product)
    end
  end

  describe 'PATCH /update' do
    let(:product) { create(:product) }

    context 'with valid parameters' do
      it 'updates the Product attributes' do
        patch product_path(product), params: { product: valid_attributes }
        product.reload
        expect(product.name).to eq(valid_attributes[:name])
        expect(product.description).to eq(valid_attributes[:description])
        expect(product.visible).to eq(valid_attributes[:visible])
      end

      it 'redirects to the products list with HTML format' do
        patch product_path(product), params: { product: valid_attributes }
        expect(response).to redirect_to(products_path)
      end

      it 'sets a success notice' do
        patch product_path(product), params: { product: valid_attributes }
        expect(flash[:success]).to eq(I18n.t('products.update.success'))
      end

      it 'responds with turbo stream format' do
        put product_path(product), params: { product: valid_attributes }, as: :turbo_stream
        expect(response.media_type).to eq Mime[:turbo_stream]
      end
    end

    context 'with invalid parameters' do
      it 'does not update the Product' do
        original_name = product.name
        patch product_path(product), params: { product: { name: '' } }
        product.reload
        expect(product.name).to eq(original_name)
      end

      it 'renders the edit template with unprocessable_entity status' do
        patch product_path(product), params: { product: { name: '' } }
        expect(response).to render_template(:edit)
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context 'when the product is not found' do
      it 'redirects to the products list' do
        patch product_path(999), params: { product: valid_attributes }
        expect(response).to redirect_to(products_path)
      end

      it 'sets an error alert' do
        patch product_path(999), params: { product: valid_attributes }
        expect(flash[:alert]).to eq(I18n.t('products.shared.not_found'))
      end
    end
  end

  describe 'DELETE /destroy' do
    it 'assigns the product to @product' do
      product = create(:product)

      delete product_path(product)
      expect(assigns(:product)).to eq(product)
    end

    it 'deletes the product' do
      product = create(:product)
      expect {
        delete product_path(product)
      }.to change(Product, :count).by(-1)
    end
  end

  describe 'GET /products/search' do
    it 'returns http success' do
      get '/products/search', params: { query: 'test' }, as: :turbo_stream
      expect(response).to have_http_status(:success)
    end

    it 'assigns the products to @products' do
      product = create(:product)
      get '/products/search', params: { query: product.name }, as: :turbo_stream
      expect(assigns(:products)).to include(product)
    end
  end

  describe 'POST /products/comments' do
    let(:product) { create(:product) }
    let(:valid_comment_params) { { comment: { message: 'Test comment', comentable_id: product.id, comentable_type: product.class.name } } }
    let(:invalid_comment_params) { { comment: { message: '', comentable_id: product.id, comentable_type: product.class.name } } }

    context 'with valid parameters' do
      it 'creates a new comment' do
        expect {
          post product_comments_path(product), params: valid_comment_params
        }.to change(Comment, :count).by(1)
      end

      it 'redirects to the product' do
        post product_comments_path(product), params: valid_comment_params
        expect(response).to redirect_to(product_path(product))
      end
    end

    context 'with invalid parameters' do
      it 'responds with unprocessable_entity status' do
        post product_comments_path(product), params: invalid_comment_params
        expect(response).to have_http_status(:redirect)
      end

      it 'does not create a new comment' do
        expect {
          post product_comments_path(product), params: invalid_comment_params
        }.not_to change(Comment, :count)
      end
    end
  end
end
