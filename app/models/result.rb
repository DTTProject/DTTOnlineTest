class Result < ApplicationRecord
  belongs_to :question
  belongs_to :test
  belongs_to :answer

  scope :is_corrects, -> do
    joins(:answer).where answers: {correct: true}
  end
end
