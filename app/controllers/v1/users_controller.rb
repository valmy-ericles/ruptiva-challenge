module V1
  class UsersController < ApiController
    before_action :load_user, only: %i[show update destroy]
    rescue_from Pundit::NotAuthorizedError, with: :unauthorized

    def index
      @users = User.all
      authorize @users
    end

    def show
      authorize @user
    end

    def update
      @user.attributes = user_params
      authorize @user
      save_user!
    end

    def destroy
      @user.for_trash
      authorize @user

      head :no_content
    end

    private

    def unauthorized
      render_errors(message: 'Forbidden access', status: :forbidden)
    end

    def load_user
      @user = User.find(params[:id])
    end

    def user_params
      return {} unless params.key?(:user)

      params.require(:user).permit(:id, :first_name, :last_name, :email, :role)
    end

    def save_user!
      @user.save!
      render :show
    rescue StandardError
      render_errors(fields: @user.errors.messages)
    end
  end
end
