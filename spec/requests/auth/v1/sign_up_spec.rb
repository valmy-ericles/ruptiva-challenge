require 'rails_helper'

RSpec.describe 'Auth V1 Sign up', type: :request do
  let(:url) { '/auth/v1/user' }

  context 'with valid params' do
    let(:user_params) { attributes_for(:user, role: nil) }

    it 'adds new user' do
      expect {
        post url, params: user_params
      }.to change(User, :count).by(1)
    end

    it 'adds user as :user' do
      post url, params: user_params
      expect(User.last.role).to eq 'user'
    end

    it 'returns :ok status' do
      post url, params: user_params
      expect(response).to have_http_status(:ok)
    end
  end

  context 'with invalid params' do
    let(:user_invalid_params) { attributes_for(:user, email: nil) }

    it 'does not add a new user' do
      expect {
        post url, params: user_invalid_params
      }.to_not change(User, :count)
    end

    it 'return :unprocessable_entity status' do
      post url, params: user_invalid_params
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end
end
