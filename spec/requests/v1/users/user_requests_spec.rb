require 'rails_helper'

RSpec.describe 'V1::Users as :user', type: :request do
  let(:user) { create(:user) }

  context 'GET /users' do
    let(:url) { '/v1/users' }
    let!(:users) { create_list(:user, 5) }

    before(:each) { get url, headers: auth_header(user) }

    include_examples 'forbidden access'
  end

  context 'SHOW /users/:id' do
    let!(:user_1) { create(:user) }
    let!(:user_2) { create(:user) }

    let(:url_1) { "/v1/users/#{user_1.id}" }
    let(:url_2) { "/v1/users/#{user_2.id}" }

    context 'when valid params' do
      it 'get other user' do
        get url_1, headers: auth_header(user_1)
        expect(body_json['user']).to eq(user_1.as_json(only: %i[
                                                         id
                                                         first_name
                                                         last_name
                                                         email
                                                         role
                                                       ]))
        expect(response).to have_http_status(:ok)
      end
    end

    context 'when invalid params' do
      before(:each) { get url_1, headers: auth_header(user_2) }
      include_examples 'forbidden access'
    end
  end
end
