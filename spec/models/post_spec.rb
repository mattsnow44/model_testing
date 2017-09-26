require 'rails_helper'

RSpec.describe Post, type: :model do
  before(:each) do
    @user = User.create(email: 'test@test.com', password: 'password',
                first_name: 'test', last_name: 'tester')
  end

  context 'with multiple posts' do
    describe '.by_title' do
      it 'sorts post alphabetically by title' do
      @user.posts.create(title: 'C Title', body: 'This is the body', private: false)
      @user.posts.create(title: 'B Title', body: 'This is the body', private: false)
      @user.posts.create(title: 'A Title', body: 'This is the body', private: false)

        posts = Post.all.by_title
        expect(posts[0].title).to eq('A Title')
        expect(posts[1].title).to eq('B Title')
        expect(posts[2].title).to eq('C Title')
      end
    end
  end


  context 'with a single post' do
    describe 'associations' do
      it { should belong_to(:user) }
    end

    describe 'validations' do
      it { should validate_presence_of(:title)}
      it { should validate_presence_of(:body)}
    end

    describe '#info' do
      it 'returns user.full_name wrote the post titled: post.title' do
        post = @user.posts.create(title: 'Test Title', body: 'This is the body', private: false)

        expect(post.info).to eq("#{@user.full_name} wrote the post titled: #{post.title}")
      end
    end
  end
end
