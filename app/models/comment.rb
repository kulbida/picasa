class Comment < ActiveRecord::Base

  attr_accessible :picture_id, :text

  validates :text, :presence => true

  belongs_to :user
  
  default_scope :order => 'created_at DESC'

  delegate :username, :to => :user, :prefix => false

  def self.fetch_by_picture_id(picture_id)
    select('comments.id, comments.user_id, comments.created_at, comments.text, users.username as username').joins('left outer join users on comments.user_id = users.id').where("comments.picture_id = '#{picture_id}'")
  end

end
