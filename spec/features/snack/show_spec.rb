require "rails_helper"

RSpec.describe "Snack Show page" do
  it "shows snack and vending machine info" do
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

    visit "/snacks/#{snack1.id}"

    expect(page).to have_content(snack1.name)
    expect(page).to have_content(snack1.price)
    save_and_open_page
    snack1.machines.each do |machine|
      expect(page).to have_content(machine.location)
      expect(page).to have_content(machine.average_snack_price)
      expect(page).to have_content(machine.snack_type_count)
    end
  end
end
