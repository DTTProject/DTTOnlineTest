class Result < ApplicationRecord
  belongs_to :question
  belongs_to :test
  belongs_to :answer
end
