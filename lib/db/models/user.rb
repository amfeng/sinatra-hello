require 'bcrypt'

class User
  include Mongoid::Document

  field :email, :type => String
  field :password, :type => String

  def password=(password)
    super(BCrypt::Password.create(password))
  end

  def authenticate(attempt)
    BCrypt::Password.new(self.password) == attempt
  end
end
