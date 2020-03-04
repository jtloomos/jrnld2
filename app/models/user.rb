class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :reminders
  has_many :entries
  has_many :entry_tags, through: :entries

  def tags
    self.entry_tags.map do |entry_tag|
      entry_tag.tag
    end
  end
end
