require 'rails_helper'

RSpec.describe ProductsController, type: :controller do
  describe 'GET #index' do
    subject { get :index }

    it { should have_http_status(:success) }
  end

  describe 'GET #show' do
    let(:product) { create(:product) }
    subject { get :show, params: { id: product.id } }

    it { should have_http_status(:success) }
  end

  describe 'POST #create' do
  let(:category) { create(:category) }
    let(:product_params) { { product: { name: 'Product', description: 'Description', price: 100, category } } }
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
