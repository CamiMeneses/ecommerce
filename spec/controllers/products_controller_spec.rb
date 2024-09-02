require 'rails_helper'

RSpec.describe ProductsController, type: :controller do
  let(:category1) { create(:category, name: 'home') }
  let(:category2) { create(:category, name: 'technology') }
  let!(:product1) { create(:product, price: 100, category: category1) }
  let!(:product2) { create(:product, price: 200, category: category2) }

  describe 'GET #index' do
    it 'returns all products' do
      get :index
      expect(response).to have_http_status(:success)
    end

    it 'returns only products in the specified category' do
      get :index, params: { category_id: product1.category.id }
      expect(assigns(:products)).to contain_exactly(product1)
    end

    it 'returns only products between the rank' do
     get :index, params: { min_price: 150, max_price: 200 }
      expect(assigns(:products)).to contain_exactly(product2)
    end
  end

  describe 'GET #show' do
    let(:product) { create(:product) }
    subject { get :show, params: { id: product.id } }

    it { should have_http_status(:success) }
  end

  describe 'POST #create' do
  let(:category) { create(:category) }
    let(:product_params) { { product: { name: 'Product', description: 'Description', price: 100, category_id: category.id } } }
    let(:product) { create(:product) }
    subject { post :create, params: product_params }

    it { should have_http_status(:found) }

    context 'when params are not valid' do
      let(:product_params) { { product: { name: '', description: '', price: '' } } }

      it { should have_http_status(:unprocessable_entity) }
    end
  end

  describe 'PATCH #update' do
    let(:product) { create(:product) }
    let(:product_params) { { id: product.id, product: { name: 'Product', description: 'Description', price: 100 } } }

    subject { patch :update, params: product_params }

    it { should have_http_status(:found) }

    context 'when params are not valid' do
      let(:product_params) { { id: product.id, product: { price: nil } } }

      it { should have_http_status(:unprocessable_entity) }
    end
  end

  describe 'DELETE #destroy' do
    let(:product) { create(:product) }

    subject { delete :destroy, params: { id: product.id } }

    it { should have_http_status(:found) }
  end
end
