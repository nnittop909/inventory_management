class Member < User
  enum role: [:member]
  has_many :orders
  has_many :line_items, through: :orders
  has_many :refunds
  before_save :set_email
  def name
    full_name
  end

  def email_required?
    false
  end

  private
  def set_email
    self.email = "#{self.first_name.downcase}#{rand(99999)}@#{self.last_name.downcase}.com"
  end
end
