class User < ActiveRecord::Base
  acts_as_reader
  mount_uploader :image, ImageUploader

  devise :confirmable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :lockable,
         :omniauthable, :omniauth_providers => Devise.omniauth_providers

  before_save do
    self.first_name = first_name.to_s.titleize
    self.last_name = last_name.to_s.titleize
    self.address = address.to_s.capitalize
    self.city = city.to_s.capitalize
    self.personal_code = personal_code.to_s.upcase
  end

  validate :password_black_list, if: :password_required?
  validates :first_name, :last_name, :personal_code, :phone_number, :address, :zip_code,
            :city, presence: true, :on => :update
  validates :first_name, :last_name, :city, length: { maximum: 50 }
  validates :description, length: { maximum: 2000 }
  validates :language, length: { maximum: 200 }
  validates :address, length: { in: 3..200 }, :on => :update

  validates :first_name, :last_name, :city, format: {
      with: /\A\p{L}+((\s|-)\p{L}+){,3}\z/,
      message: 'saa sisältää vain kirjaimia sekä väliliviivan tai välin nimien välissä'
  }, :on => :update
  validates :phone_number, phone: { possible: true }, :on => :update
  validates :zip_code, format: {
      with: /\A(FI-)?[0-9]{5}\z/,
      message: 'ei ole Suomessa kelvollinen'
  }, :on => :update
  validates :personal_code, uniqueness: true, hetu: true, :unless => :passport_number_is_used?, :on => :update

  validates_processing_of :image, if: :image_is_set?
  validates_integrity_of :image, if: :image_is_set?
  validates :image, :file_size => {
      :maximum => 5.megabytes.to_i
  }, if: :image_is_set?

  has_many :posts, dependent: :destroy
  has_many :candidates, -> { where denied:false }, dependent: :destroy
  has_many :tasks, through: :candidates, source: :post

  scope :active, -> { where deleted_at:false }
  scope :deleted, -> { where deleted_at:true }

  def image_is_set?
    image.present?
  end

  def passport_number_is_used?
    !passport_number.nil? && passport_number == true
  end

  def soft_delete
    update_attribute(:deleted_at, Time.current)
  end

  # ensure user account is active
  def active_for_authentication?
    super && !deleted_at
  end

  # provide a custom message for a deleted account
  def inactive_message
    !deleted_at ? super : :deleted_account
  end

  def is_social?
    !provider.nil?
  end

  def denied_tasks
    Post.active.valid.joins(:candidates).where(:candidates => {denied:true})
  end

  def password_black_list
    blacklist = []
    file = File.join(Rails.root, 'app', 'models', 'concerns', 'blacklist')
    File.open(file) do |f|
      f.each_line do |line|
        blacklist << line[0..(line.size-2)]
      end
    end
    errors.add(:password, 'on mustalistattu') if blacklist.include? password
  end

  def self.find_for_oauth(auth)
    if !where(email: auth.info.email).empty?
      user = find_by(email: auth.info.email)
      user.update_attribute(:provider, auth.provider)
      user.update_attribute(:uid, auth.uid)
      user.update_attribute(:remote_image_url, auth.info.image)
      user
    else
      if where(provider: auth.provider, uid: auth.uid).first.nil?
        user = User.new provider:auth.provider,
                        uid:auth.uid,
                        first_name:auth.info.first_name.present? ? auth.info.first_name : '',
                        last_name:auth.info.last_name.present? ? auth.info.last_name : '',
                        email: auth.info.email.present? ? auth.info.email : 'vaihda@minut.com',
                        remote_image_url: auth.info.image,
                        password:Devise.friendly_token[0,20]
        user.save!
        user
      else
        where(provider: auth.provider, uid: auth.uid).first
      end
    end
  end

end