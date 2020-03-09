class Analytic < ApplicationRecord
  has_many :word_frequencies
  has_many :name_frequencies
  has_many :emotions
  belongs_to :entry
end
