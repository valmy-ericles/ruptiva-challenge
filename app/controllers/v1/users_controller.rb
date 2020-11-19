module V1
  class UsersController < ApiController
    before_action :load_user, only: %i[show]

    def index
      @users = User.all
    end

    def show; end

    private

    def load_user
      @user = User.find(params[:id])
    end
  end
end
