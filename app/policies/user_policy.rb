class UserPolicy
  attr_reader :user, :record

  def initialize(current, another_user)
    @user = current
    @record = another_user
  end

  def index?
    user.admin?
  end

  def show?
    check
  end

  def update?
    check
  end

  def destroy?
    check
  end

  private

  def check
    user.admin? || user.id == record.id
  end
end
