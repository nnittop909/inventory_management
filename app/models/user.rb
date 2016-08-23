class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :addresses
  has_many :orders
  has_many :sales, class_name: 'Order', foreign_key: 'employee_id'
  has_many :line_items, through: :orders
  accepts_nested_attributes_for :addresses
  has_attached_file :profile_photo,
                    styles: { large: "120x120>",
                    medium: "70x70>",
                    thumb: "40x40>",
                    small: "30x30>",
                    x_small: "20x20>"},
                      default_url: ":style/profile_default.jpg",
                    :path => ":rails_root/public/system/:attachment/:id/:style/:filename",
                    :url => "/system/:attachment/:id/:style/:filename"
  validates_attachment :profile_photo, content_type: { content_type: ["image/jpeg", "image/gif", "image/png"] }
  validates :first_name, :last_name, :role, presence: true
  before_save :set_email
  enum role: [:member]

  
  def full_name
    "#{first_name} #{last_name}"
  end

  # def address
  #   addresses.first.details
  # end
  
  def email_required?
    false
  end

  private
  def set_email
    self.email = "#{self.first_name.downcase}#{rand(99999)}@#{self.last_name.downcase}.com"
  end
end
