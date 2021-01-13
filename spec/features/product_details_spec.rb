require 'rails_helper'

RSpec.feature "Visitor navigates to home page", type: :feature, js: true do

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

  scenario "They can view an individual product page" do
    # ACT
    visit root_path

    # DEBUG / VERIFY
    find_link(@products[0].name).click

    expect(page).to have_content @products[0].quantity  
    expect(page).to have_content "Quantity"  
    expect(page).to have_content @category.name

    page.save_screenshot

  end

end
