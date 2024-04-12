class User < ApplicationRecord
  has_secure_password

  validates :last_name, presence: true
  validates :first_name, presence: true
  validates :birthday, presence: true

  enum role: { student: 0, teacher: 1, headteacher: 2, admin: 3 }
  after_initialize :set_user_role, if: :new_record?

  def set_user_role
    role || :student
  end

  def reached_max_attempts_limit?
    failed_attempts > 7
  end

  def name
    "#{last_name} #{first_name}"
  end

  def confirmed?
    !confirmed_at.nil?
  end
end
