require "rails_helper"

RSpec.describe Machine, type: :model do
  describe "validations" do
    it { should validate_presence_of :location }
    it { should belong_to :owner }
    it { should have_many :machine_snacks }
    it { should have_many(:snacks).through(:machine_snacks) }
  end

  describe "Average Snack Price" do
    it "should return average price of snacks" do
      owner = Owner.create!(name: "Jeff")
      machine = owner.machines.create!(location: "Denver, CO")
      snack1 = Snack.create!(name: "Doritos", price: 2.00)
      snack2 = Snack.create!(name: "Ruffles", price: 1.00)
      machine_snack1 = MachineSnack.create!(machine_id: machine.id, snack_id: snack1.id)
      machine_snack2 = MachineSnack.create!(machine_id: machine.id, snack_id: snack2.id)

      expect(machine.average_snack_price).to eq(1.5)
    end
  end
end
