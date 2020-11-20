require 'rails_helper'

RSpec.describe 'V1::Users as without authentication', type: :request do
  context 'GET /users' do
    let(:url) { '/v1/users' }
    let!(:users) { create_list(:user, 5) }

    before(:each) { get url }

    include_examples 'unauthenticated access'
  end

  context 'SHOW /user' do
    let!(:user) { create(:user) }
    let(:url) { "/v1/users/#{user.id}" }

    before(:each) { get url }

    include_examples 'unauthenticated access'
  end

  context 'PATCH /user/:id' do
    let!(:user) { create(:user) }
    let(:url) { "/v1/users/#{user.id}" }

    before(:each) { get url }

    include_examples 'unauthenticated access'
  end

  context 'DELETE /user/:id' do
    let!(:user) { create(:user) }
    let(:url) { "/v1/users/#{user.id}" }

    before(:each) { delete url }

    include_examples 'unauthenticated access'
  end
end
