require "rails_helper"

RSpec.describe "Vending Machine Show page", type: :feature do
  it "should show all snack information for a machine" do
    owner = Owner.create!(name: "Jeff")
    machine = owner.machines.create!(location: "Denver, CO")
    snack1 = Snack.create!(name: "Doritos", price: 1.49)
    snack2 = Snack.create!(name: "Ruffles", price: 1.75)
    snack3 = Snack.create!(name: "Oreos", price: 2.49)
    machine_snack1 = MachineSnack.create!(machine_id: machine.id, snack_id: snack1.id)
    machine_snack2 = MachineSnack.create!(machine_id: machine.id, snack_id: snack2.id)
    machine_snack3 = MachineSnack.create!(machine_id: machine.id, snack_id: snack3.id)

    visit "/machines/#{machine.id}"

    machine.snacks.each do |snack|
      expect(page).to have_content(snack1.name)
      expect(page).to have_content(snack1.price)
    end
  end

  it "should show average price for all snacks in a machine" do
    owner = Owner.create!(name: "Jeff")
    machine = owner.machines.create!(location: "Denver, CO")
    snack1 = Snack.create!(name: "Doritos", price: 1.49)
    snack2 = Snack.create!(name: "Ruffles", price: 1.75)
    snack3 = Snack.create!(name: "Oreos", price: 2.49)
    machine_snack1 = MachineSnack.create!(machine_id: machine.id, snack_id: snack1.id)
    machine_snack2 = MachineSnack.create!(machine_id: machine.id, snack_id: snack2.id)
    machine_snack3 = MachineSnack.create!(machine_id: machine.id, snack_id: snack3.id)

    visit "/machines/#{machine.id}"

    expect(page).to have_content(machine.average_snack_price)
  end
end
