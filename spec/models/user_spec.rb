require 'rails_helper'

RSpec.describe User, type: :model do
  context 'with multiple users' do
    describe '.by_last_name' do
      before(:each) do
        User.create(first_name: 'test', last_name: 'abe', email: 't@t.com', password: 'password')
        User.create(first_name: 'test', last_name: 'babe', email: 't2@t.com', password: 'password')
        User.create(first_name: 'test', last_name: 'cade', email: 't3@t.com', password: 'password')
      end

      it 'returns all users by last name ascending' do
        users = User.all.by_last_name
        expect(users.first.last_name).to eq('abe')
        expect(users[1].last_name).to eq('babe')
        expect(users[2].last_name).to eq('cade')
      end

      it 'returns all users by last name descending' do
        users = User.all.by_last_name(false)
        expect(users.first.last_name).to eq('cade')
        expect(users[1].last_name).to eq('babe')
        expect(users[2].last_name).to eq('abe')
      end
    end
  end

  context 'with a single user' do
    before(:each) do
      @user = User.create(email: 'test@test.com', password: 'password',
                  first_name: 'test', last_name: 'tester')
    end
    # describe - describing unit test
    # context - as a user, as an admin, as a viewer

    describe 'validations' do
      it { should validate_presence_of(:first_name) }
      it { should validate_presence_of(:last_name) }
    end

    describe 'associations' do
      it { should have_many(:posts) }
    end

    describe '#info' do
      it 'returns email with sign in count' do

        expect(@user.info).to eq("#{@user.email} has signed in: #{@user.sign_in_count} times")
      end
    end

    describe '#full_name' do
      it 'returns the users full name like last_name, first_name' do

        expect(@user.full_name).to eq("#{@user.last_name}, #{@user.first_name}")
      end
    end

    describe '#display_name' do
      it 'returns the users full name like first_name last_name' do

        expect(@user.display_name).to eq("#{@user.first_name} #{@user.last_name}")
      end
    end

    describe '#has_signed_in?' do
      it 'returns true if the sign_in_count > 0' do
        @user.update(sign_in_count: 1)
        expect(@user.has_signed_in?).to eq(true)
      end

      it 'return false if the sign_in_count == 0' do
        expect(@user.has_signed_in?).to eq(false)
      end
    end
  end
end
