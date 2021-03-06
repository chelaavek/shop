class Product < ApplicationRecord
  has_many :line_items
  has_many :orders, through: :line_items
  before_destroy :ensure_not_referenced_by_any_line_item
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

  def self.search(search)
    if search
      product = Product.where("products.title LIKE ? OR products.description LIKE ?", "%#{search}%", "%#{search}%")
      if product
        self.where(id: product)
      else
        Product.all
      end
    else
      Product.all
    end
  end



  private

  def ensure_not_referenced_by_any_line_item
    if line_items.empty?
      return true
  else
    errors.add(:base, 'line items insist')
    return false
    end
  end
end
