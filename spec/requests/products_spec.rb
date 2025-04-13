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

    it 'orders products by id in descending order' do
      product1 = create(:product)
      product2 = create(:product)

      get '/products'
      expect(assigns(:products).first).to eq(product2)
      expect(assigns(:products).last).to eq(product1)
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
end
