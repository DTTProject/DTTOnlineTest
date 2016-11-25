class ApplicationRecord < ActiveRecord::Base
  include OrderDes
  self.abstract_class = true
end
