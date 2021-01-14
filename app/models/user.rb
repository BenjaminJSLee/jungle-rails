class User < ActiveRecord::Base

  has_secure_password

  has_many :reviews

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :password, length: { minimum: 3 }

  def self.authenticate_with_credentials(email, password)

    edited_email = (email.strip).downcase

    user = User.find_by(email: edited_email)
    if user != nil && user.authenticate(password)
      return user
    end
    nil
  end

end
