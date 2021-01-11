require 'rails_helper'

RSpec.describe User, type: :model do

  before :each do
    @user = User.new(
      :first_name => "Jane", 
      :last_name => "Doe", 
      :email => "test@test.com",
      #:password_digest => nil,
    )
    @user.password = "password"
  end

  describe 'Validations' do

    it "saves a user with no nil fields" do
      @user.save
      expect(@user.errors.full_messages).to be_empty
    end
    
    it "fails to save a user with a nil 'first_name' field" do
      @user.first_name = nil
      @user.save
      expect(@user.errors.full_messages).to include("First name can't be blank")
    end
    
    it "fails to save a user with a nil 'last_name' field" do
      @user.last_name = nil
      @user.save
      expect(@user.errors.full_messages).to include("Last name can't be blank")
    end
    
    it "fails to save a user with a nil 'email' field" do
      @user.email = nil
      @user.save
      expect(@user.errors.full_messages).to include("Email can't be blank")
    end

    it "saves a user with passed password confirmation" do
      @user.password_confirmation = "password"
      @user.save
      expect(@user.errors.full_messages).to be_empty
    end

    it "fails to save a user with failed password confirmation" do
      @user.password_confirmation = "IAmNotTheSamePassword"
      @user.save
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end

    it "fails to save a user that contains an email which already exists in the database" do
      @user.save
      expect(@user.errors.full_messages).to be_empty
      new_user = @user.dup
      new_user.save
      expect(new_user.errors.full_messages).to include("Email has already been taken")
    end

    it "fails to save a user that contains an email which already exists in the database (case-insensitive)" do
      @user.save
      expect(@user.errors.full_messages).to be_empty
      new_user = @user.dup
      new_user.email.upcase!
      new_user.save
      expect(new_user.errors.full_messages).to include("Email has already been taken")
    end

    it "fails to save a user whose password is below the minimum length" do
      @user.password = "hi"
      @user.password_confirmation = "hi"
      @user.save
      expect(@user.errors.full_messages).to include("Password is too short (minimum is 3 characters)")
    end

  end

  describe '.authenticate_with_credentials' do
    # examples for this class method here
    it "returns nil for a non-existant email" do
      new_user = User.authenticate_with_credentials(@user.email, @user.password)
      expect(new_user).to be_nil
    end

    it "returns the user for an existing email-password pair" do
      @user.save!
      new_user = User.authenticate_with_credentials(@user.email, @user.password)
      expect(new_user).to eq(@user)
    end

    it "returns nil for an existing email and an incorrect password" do
      @user.save!
      new_user = User.authenticate_with_credentials(@user.email, "hunter2")
      expect(new_user).to be_nil
    end

    it "returns the user for an existing email-password pair (email trailing spaces)" do
      @user.save!
      email = "     " + @user.email + " "
      new_user = User.authenticate_with_credentials(email, @user.password)
      expect(new_user).to eq(@user)
    end

    it "returns the user for an existing email-password pair (email case-insensitive)" do
      @user.save!
      email = @user.email.upcase
      new_user = User.authenticate_with_credentials(email, @user.password)
      expect(new_user).to eq(@user)
    end

  end

end
