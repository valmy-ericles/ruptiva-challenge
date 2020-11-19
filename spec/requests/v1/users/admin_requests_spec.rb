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
end
