class User < ActiveRecord::Base
  before_save { self.email = email.downcase }
  before_create :create_remember_token
  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  has_secure_password
  validates :password, length: { minimum: 6 }, :if => :password 
  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>", :header => "50x50>"}, :default_url => "/images/missing.png"
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/
  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def User.digest(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  private

    def create_remember_token
      self.remember_token = User.digest(User.new_remember_token)
    end
  def self.active_count
    where(:active => true)
  end
end
