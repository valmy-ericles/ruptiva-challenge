require 'rails_helper'

RSpec.describe 'Auth V1 Sign in', type: :request do
  context 'as :admin' do
    let!(:user) { create(:user, role: :admin, email: 'admin@test.com', password: '12345678') }

    include_examples 'sign in', 'admin@test.com', '12345678'
  end

  context 'as :user' do
    let!(:user) { create(:user, email: 'user@test.com', password: '12345678') }

    include_examples 'sign in', 'user@test.com', '12345678'
  end
end
