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

  describe "Machine Snack Kind Count" do
    it "should return Count of kinds of snacks in a machine" do
      owner = Owner.create!(name: "Jeff")

      machine1 = owner.machines.create!(location: "Denver, CO")
      machine2 = owner.machines.create!(location: "Golden, CO")

      snack1 = Snack.create!(name: "Doritos", price: 1.49)
      snack2 = Snack.create!(name: "Ruffles", price: 1.75)
      snack3 = Snack.create!(name: "Oreos", price: 2.49)
      snack4 = Snack.create!(name: "Twinkies", price: 3.49)

      machine_snack1 = MachineSnack.create!(machine_id: machine1.id, snack_id: snack1.id)
      machine_snack2 = MachineSnack.create!(machine_id: machine1.id, snack_id: snack2.id)
      machine_snack3 = MachineSnack.create!(machine_id: machine1.id, snack_id: snack3.id)

      machine_snack4 = MachineSnack.create!(machine_id: machine2.id, snack_id: snack2.id)
      machine_snack5 = MachineSnack.create!(machine_id: machine2.id, snack_id: snack4.id)

      expect(machine1.snack_type_count).to eq(3)
      expect(machine2.snack_type_count).to eq(2)
    end
  end
end
