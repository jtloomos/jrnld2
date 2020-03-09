class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :reminders
  has_many :entries
  has_many :entry_tags, through: :entries

  validates_presence_of :username, :first_name, :last_name, :birthday, :gender
  validates :username, uniqueness: true

  has_one_attached :photo
  def tags
    self.entry_tags.map do |entry_tag|
      entry_tag.tag
    end
  end
end
