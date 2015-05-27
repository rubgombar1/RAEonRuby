class Word < ActiveRecord::Base
  belongs_to :search
  has_many :entries
end
