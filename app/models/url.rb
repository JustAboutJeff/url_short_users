class Url < ActiveRecord::Base

  belongs_to :user
  
  before_save :get_short_url
  before_save :get_click_count
  validates :long_url, presence: true,
    format: { with: /http:\/\/.*|https:\/\/.*/}

  def get_short_url
    self.short_url = SecureRandom.hex(3)
  end

  def get_click_count
    self.click_count ||= 0
  end

end
