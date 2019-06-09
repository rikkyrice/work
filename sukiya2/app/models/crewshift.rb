class Crewshift < ApplicationRecord
  validates :already, {presence: true}
  validates :full_date, {presence: true}
  validates :user_id, {presence: true}

  def user
    return User.find_by(id: self.user_id)
  end
end
