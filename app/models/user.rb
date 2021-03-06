class User < ActiveRecord::Base

  has_secure_password

  validates :first_name, :last_name, :email, :password, :password_confirmation, presence: true
  validates :email, uniqueness: { case_sensitive: false }
  validates :password, length: { minimum: 8 }

  def self.authenticate_with_credentials(email, password)
    @user = User.where('lower(email) = ?', email.strip.downcase).first
    if @user && @user.authenticate(password)
      @user
    else
      nil
    end
  end

end
