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
      it 'get himself' do
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

  context 'PATCH /user/:id' do
    let(:user) { create(:user) }
    let(:url) { "/v1/users/#{user.id}" }

    context 'with valid params' do
      let(:new_first_name) { 'Jhon' }
      let(:new_last_name) { 'Doe' }

      let(:user_params) { { user: { first_name: new_first_name, last_name: new_last_name } }.to_json }

      it 'updates user' do
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

    context 'with invalid params' do
      let(:user_invalid_params) do
        { user: attributes_for(:user, first_name: nil) }.to_json
      end

      it 'does not update user' do
        old_first_name = user.first_name
        patch url, headers: auth_header(user), params: user_invalid_params
        user.reload
        expect(user.first_name).to eq old_first_name
      end

      it 'returns error messages' do
        patch url, headers: auth_header(user), params: user_invalid_params
        expect(body_json['errors']['fields']).to have_key('first_name')
      end

      it 'returns unprocessable_entity status' do
        patch url, headers: auth_header(user), params: user_invalid_params
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context 'when tries update another user' do
      let(:another_user) { create(:user) }

      let(:user_params) do
        { user: attributes_for(:user, first_name: 'Jhon') }.to_json
      end

      before(:each) { patch url, headers: auth_header(another_user), params: user_params }

      include_examples 'forbidden access'
    end
  end

  context 'DELETE /users/:id' do
    let!(:user) { create(:user) }
    let(:url) { "/v1/users/#{user.id}" }

    context 'when deletes himself' do
      it 'removes user' do
        delete url, headers: auth_header(user)
        expect(User.find_by(id: user.id)).to be_nil
        expect(User.in_the_trash.find_by(id: user.id)).to be_truthy
      end

      it 'returns success status' do
        delete url, headers: auth_header(user)
        expect(response).to have_http_status(:no_content)
      end

      it 'does not return any body content' do
        delete url, headers: auth_header(user)
        expect(body_json).to_not be_present
      end
    end

    context 'when deletes another user' do
      let(:another_user) { create(:user) }
      before(:each) { delete url, headers: auth_header(another_user) }

      include_examples 'forbidden access'
    end
  end
end
