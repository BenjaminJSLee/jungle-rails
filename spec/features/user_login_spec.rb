require 'rails_helper'

RSpec.feature "UserLogins", type: :feature, js: true do

  before :each do
    @user = User.create!(
      first_name: "Ben",
      last_name: "Lee",
      email: "test@test.com",
      password: "password"
    )
  end

  scenario "" do
    # ACT
    visit root_path

    find_link("Login").click

    expect(page).to have_content "Login"
    expect(page).to have_content "Email:"
    expect(page).to have_content "Password:"
    
    fill_in :email, with: @user.email
    fill_in :password, with: @user.password

    find_button("Submit").click

    expect(page).to have_content @user.email

    page.save_screenshot

  end

end
