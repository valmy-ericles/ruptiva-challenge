require 'rails_helper'

RSpec.describe 'V1::Users as :user', type: :request do
  let(:user) { create(:user) }

  context 'GET /users' do
    let(:url) { '/v1/users' }
    let!(:users) { create_list(:user, 5) }

    before(:each) { get url, headers: auth_header(user) }

    include_examples 'forbidden access'
  end
end
