class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  scope :in_the_trash, -> { unscope(where: :deleted).where(deleted: true) }

  def for_trash
    update(deleted: true)
  end
end
