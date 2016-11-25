module OrderDes
  extend ActiveSupport::Concern
  included do
    scope :order_desc, -> { order("#{self.to_s.tableize}.created_at desc") }
  end
end
