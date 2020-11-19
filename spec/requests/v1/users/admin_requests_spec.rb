require 'rails_helper'

RSpec.describe 'V1::Users as :admin', type: :request do
  let(:user) { create(:user, role: :admin) }

  context 'GET /users' do
    let(:url) { '/v1/users' }
    let!(:users) { create_list(:user, 2) }

    it 'returns all users' do
      users.push(user)

      get url, headers: auth_header(user)

      expect(body_json['users']).to contain_exactly(*users.as_json(only: %i[
                                                                     id
                                                                     first_name
                                                                     last_name
                                                                     email
                                                                     role
                                                                   ]))
    end

    it 'Returns success status' do
      get url, headers: auth_header(user)
      expect(response).to have_http_status(:ok)
    end
  end

  context 'SHOW /user' do
    let!(:user) { create(:user) }
    let(:url) { "/v1/users/#{user.id}" }

    it 'returns user' do
      get url, headers: auth_header(user)

      expect(body_json['user']).to eq(user.as_json(only: %i[
                                                     id
                                                     first_name
                                                     last_name
                                                     email
                                                     role
                                                   ]))
    end

    it 'Returns success status' do
      get url, headers: auth_header(user)
      expect(response).to have_http_status(:ok)
    end
  end

  context 'PATCH /user' do
    let(:user) { create(:user) }
    let(:url) { "/v1/users/#{user.id}" }

    context 'with valid params' do
      let(:new_first_name) { 'Jhon' }
      let(:new_last_name) { 'Doe' }

      let(:user_params) { { user: { first_name: new_first_name, last_name: new_last_name } }.to_json }

      it 'updates User' do
        patch url, headers: auth_header(user), params: user_params
        user.reload
        expect(user.first_name).to eq new_first_name
        expect(user.last_name).to eq new_last_name
      end

      it 'returns updated user' do
        patch url, headers: auth_header(user), params: user_params
        user.reload
        expected_user = user.as_json(only: %i[id first_name last_name email role])
        expect(body_json['user']).to eq expected_user
      end

      it 'returns success status' do
        patch url, headers: auth_header(user), params: user_params
        expect(response).to have_http_status(:ok)
      end
    end

  end
end
