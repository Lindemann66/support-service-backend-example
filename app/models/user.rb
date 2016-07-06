class User < ActiveRecord::Base
  has_many :session, :dependent => :destroy
  has_many :requests, :dependent => :destroy

  CUSTOMER_ROLE_ID = 1
  SUPPORT_ROLE_ID = 2
  ADMIN_ROLE_ID = 3

  def support?
    role == SUPPORT_ROLE_ID
  end

  def customer?
    role == CUSTOMER_ROLE_ID
  end

  def admin?
    role == ADMIN_ROLE_ID
  end
end
