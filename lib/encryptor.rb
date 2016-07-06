require 'digest'

class Encryptor
  def self.encrypt(text)
    Digest::SHA256.hexdigest(text)
  end
end