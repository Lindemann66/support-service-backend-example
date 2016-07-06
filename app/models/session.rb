require 'digest/md5'

class Session < ActiveRecord::Base
  belongs_to :user

  before_create :generate_token

  private

  def generate_token
    self.token = Digest::MD5.hexdigest(Time.new.to_s + rand(9999999999).to_s)
  end
end
