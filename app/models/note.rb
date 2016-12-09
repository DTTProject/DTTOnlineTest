class Note < ApplicationRecord
  belongs_to :user
  belongs_to :week
  belongs_to :exam
end
