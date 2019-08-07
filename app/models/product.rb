class Product < ApplicationRecord
  validates :title, presence: true
  validates_numericality_of :price , {:greater_than_or_equal_to => 0.01}
  validates :title, uniqueness: true
  validates :image_url, allow_blank: true, format: {
      with: %r{\.(gif|jpg|jpeg|png)\Z}i,
      message: 'URL должен указывать на изображение формата GIF, JPG, JPEG или PNG.'
  }
  def self.latest
    Product.order(:updated_at).last
  end
end
