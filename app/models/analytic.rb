class Analytic < ApplicationRecord
  has_many :word_frequencies, dependent: :destroy
  has_many :name_frequencies, dependent: :destroy
  has_many :emotions, dependent: :destroy
  belongs_to :entry
end
