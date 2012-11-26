class User < ActiveRecord::Base

  attr_accessible :username, :provider, :uid, :email
  has_many :comments

  def to_param
    google_uid    
  end

  def google_uid
    email.split('@').first
  end

  def fetch_albums
    fetcher = AlbumFetcher.new(google_uid)
    fetcher.fetch_albums
  end

  def fetch_album_pictures(url)
    fetcher = AlbumFetcher.new(google_uid)
    fetcher.fetch_pictures(url)
  end

  class << self

    def find_by_google_id(google_uid)
      User.where('email like ?', "#{google_uid}@#{APP_CONFIG[:google_mail_host]}")
    end

    def find_for_google_oauth(auth, signed_in_resource=nil)
      user = User.where(:provider => auth.provider, :uid => auth.uid).first
      unless user
        user = User.create(
          :username => auth.info.name,
          :provider => auth.provider,
          :uid => auth.uid,
          :email => auth.info.email
        )
      end
      user
    end

  end

end
