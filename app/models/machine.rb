class Machine < ApplicationRecord
  validates_presence_of :location
  has_many :machine_snacks
  has_many :snacks, through: :machine_snacks

  belongs_to :owner

  def average_snack_price
    snacks.average("price").round(2)
  end

  def snack_type_count
    snacks.ids.count
  end
end
