class User < ActiveRecord::Base

  has_many :urls

  before_save :get_encrypted_password
  validates :email, uniqueness: true, presence: true,
          format: { with: /.*@.*.[a-z]*/}

  private

  def self.authenticate(login_email, login_password)
    @user = self.find_by_email(login_email)
    return nil unless @user
    return @user if BCrypt::Password.new(@user.password) == login_password && @user.email == login_email
  end

  def get_encrypted_password
    self.password = BCrypt::Password.create(self.password)
  end

end




# class User < ActiveRecord::Base
#   include BCrypt

#   def password
#     @password ||= Password.new(password_hash)
#   end

#   def password=(pass)
#     @password = Password.create(pass)
#     self.password_hash = @password
#   end

#   def self.create(params={})
#     @user = User.new(:email => params[:email], :name => params[:name])
#     @user.password = params[:password]
#     @user.save!
#     @user
#   end

#   def self.authenticate(params)
#     user = User.find_by_name(params[:name])
#     (user && user.password == params[:password]) ? user : nil
#   end
# end
