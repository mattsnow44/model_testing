class Post < ApplicationRecord
  belongs_to :user

  validates_presence_of :title, :body

  def self.by_title
    order(:title)
  end

  def info
    "#{user.full_name} wrote the post titled: #{title}"
  end
end
