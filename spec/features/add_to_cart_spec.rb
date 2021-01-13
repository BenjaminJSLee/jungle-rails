require 'rails_helper'

RSpec.feature "Visitor adds to their cart", type: :feature, js: true do

  # SETUP
  before :each do
    @category = Category.create! name: 'Apparel'
    @products = []
    10.times do |n|
      @products.push(@category.products.create!(
        name:  Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        image: open_asset('apparel1.jpg'),
        quantity: 10,
        price: 64.99
      ))
    end
  end

  scenario "They see all products" do
    # ACT
    visit root_path

    # DEBUG / VERIFY

    expect(page).to have_content "My Cart (0)"

    first('.product').find_button("Add").click

    expect(page).to have_content "My Cart (1)"

    save_screenshot

  end

end
