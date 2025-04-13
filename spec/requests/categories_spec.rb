require 'rails_helper'

RSpec.describe 'Categories', type: :request do
  let(:valid_attributes) { FactoryBot.attributes_for(:category) }
  let(:invalid_attributes) { { name: nil } }

  describe 'GET /index' do
    it 'renders a successful response' do
      get '/categories'
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /show' do
    it 'returns http success' do
      category = create(:category)

      get category_path(category)
      expect(response).to have_http_status(:success)
    end

    it 'assigns the category to @category' do
      category = create(:category)

      get category_path(category)
      expect(assigns(:category)).to eq(category)
    end

    context 'when the category is not found' do
      it 'redirects to the categories list' do
        get category_path(999)
        expect(response).to redirect_to(categories_path)
      end
    end
  end

  describe 'GET /new' do
    it 'returns http success' do
      get '/categories/new'
      expect(response).to have_http_status(:success)
    end

    it 'assigns a new category to @category' do
      get '/categories/new'
      expect(assigns(:category)).to be_a_new(Category)
    end
  end

  describe 'GET /edit' do
    it 'returns http success' do
      category = create(:category)

      get edit_category_path(category)
      expect(response).to have_http_status(:success)
    end

    it 'assigns the category to @category' do
      category = create(:category)

      get edit_category_path(category)
      expect(assigns(:category)).to eq(category)
    end

    context 'when the category is not found' do
      it 'redirects to the categories list' do
        get category_path(999)
        expect(response).to redirect_to(categories_path)
      end
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      it 'creates a new Category' do
        expect {
          post categories_url, params: { category: valid_attributes }
        }.to change(Category, :count).by(1)
      end

      it 'redirects to the created category' do
        post categories_url, params: { category: valid_attributes }
        expect(response).to redirect_to(categories_path)
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new Category' do
        expect {
          post categories_url, params: { category: invalid_attributes }
        }.to change(Category, :count).by(0)
      end

      it 'renders a response with 422 status' do
        post categories_url, params: { category: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'PATCH /update' do
    context 'with valid parameters' do
      let(:new_attributes) { { name: 'New Category' } }

      it 'updates the requested category' do
        category = Category.create! valid_attributes
        patch category_url(category), params: { category: new_attributes }
        category.reload
        expect(category.name).to eq(new_attributes[:name])
      end

      it 'redirects to the categories' do
        category = Category.create! valid_attributes
        patch category_url(category), params: { category: new_attributes }
        category.reload
        expect(response).to redirect_to(categories_path)
      end
    end

    context 'with invalid parameters' do
      it 'renders a response with 422 status' do
        category = Category.create! valid_attributes
        patch category_url(category), params: { category: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'DELETE /destroy' do
    it 'assigns the category to @category' do
      category = create(:category)

      delete category_url(category)
      expect(assigns(:category)).to eq(category)
    end

    it 'deletes the category' do
      category = create(:category)
      expect {
        delete category_url(category)
      }.to change(Category, :count).by(-1)
    end

    it 'redirects to the categories list' do
      category = create(:category)
      delete category_url(category)
      expect(response).to redirect_to(categories_url)
    end
  end
end
