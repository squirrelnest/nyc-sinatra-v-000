class Landmark < ActiveRecord::Base

  belongs_to :figure

  validates :name, uniqueness: true
  # validates :year_completed, numericality: true

end
