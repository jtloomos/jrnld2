class Analytic < ApplicationRecord
  has_many :word_frequencies
  belongs_to :entry
end
