class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable ,:omniauth_providers => [:facebook, :google_oauth2]
  has_many :posts , :dependent => :destroy
  has_many :replies, :dependent => :destroy

  has_many :post_likeships
  has_many :liked_post, :through => :post_likeships, :source => :post

  has_many :user_postships, :dependent => :destroy
  has_many :fav_posts, :through => :user_postships, :source => :post

  has_many :friendships
  has_many :friends, ->{ where( "friendships.status" => "confirmed") },  :through => :friendships
  has_many :inverse_friendships, :class_name => "Friendship", :foreign_key => "friend_id"
  has_many :inverse_friends,->{ where( "friendships.status" => "confirmed") }, :through => :inverse_friendships, :source => :user

  include Gravtastic
  gravtastic

  def all_friends
    (friends + inverse_friends).uniq
  end

  def find_friendship(user)
    friendships.where( :friend => user ).first ||
    user.friendships.where( :friend => self ).first
  end

  def is_friend?(user)
    all_friends.include?(user)
  end

  def pending_friendship?(user)
    self.friendships.pending.where( :friend => user ).exists?
  end

  def inverse_pending_friendship?(user)
    user.friendships.pending.where( :friend => self ).exists?
  end

  def ignored_friendship?(user)
    self.friendships.ignored.where( :friend => user ).exists?
  end

  def inverse_ignored_friendship?(user)
    user.friendships.ignored.where( :friend => self ).exists?
  end




  def short_name
  	self.email.split("@").first
  end

   def admin?
    self.role == "admin"
   end

  def liked_post?(post)
    self.liked_post.include?(post)
  end

  def faved_post?(post)
    self.fav_posts.include?(post)
  end

  def self.from_omniauth(auth)
    # Case 1: Find existing user by facebook uid
    user = User.find_by_fb_uid( auth.uid )
    byebug
    if user
      user.fb_token = auth.credentials.token
      #user.fb_raw_data = auth
      user.save!
      return user
    end

    # Case 2: Find existing user by email
    existing_user = User.find_by_email( auth.info.email )
    if existing_user
      existing_user.fb_uid = auth.uid
      existing_user.fb_token = auth.credentials.token
      #existing_user.fb_raw_data = auth
      existing_user.save!
      return existing_user
    end

    # Case 3: Create new password
    user = User.new
    user.fb_uid = auth.uid
    user.fb_token = auth.credentials.token
    user.email = auth.info.email
    user.nickname = auth.info.name
    user.password = Devise.friendly_token[0,20]
    #user.fb_raw_data = auth
    user.save!
    return user
  end

  def self.from_omniauth_google(access_token)
    data = access_token.info
    user = User.where(:email => data["email"]).first

    # Uncomment the section below if you want users to be created if they don't exist
    unless user
      user = User.create(nickname: data["name"],
             email: data["email"],
             password: Devise.friendly_token[0,20])
    end
    user
  end


end
