class User < ApplicationRecord
  has_many :messages, dependent: :destroy

  def jwt_token
    JwtHelper.encode_user(self)
  end
end
