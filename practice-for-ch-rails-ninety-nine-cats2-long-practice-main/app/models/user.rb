class User < ApplicationRecord
    validates :username, uniqueness: true, presence: true
    validates :password_digest, presence: true
    validates :session_token, presence: true, uniqueness: true

    before_validation :ensure_session_token

    def password=(password)
        self.password_digest = BCrypt::Password.create(password)
        @password = password
    end

    def is_password?(password)
        password_object = BCrypt::Password.new(self.password_digest)
        password_object.is_password?(password)
    end

    def self.find_by_credentials(username, password)
        user = User.find_by(username: username)

        if user && user.is_password?(password)
            user
        else
            nil
        end

    end

    def reset_session_token!
        self.session_token = SecureRandom::urlsafe_base64
        self.save!
        self.session_token
    end


    private

    def ensure_session_token
        self.session_token ||= SecureRandom::urlsafe_base64
    end

    def generate_unique_session_token
        while true 
            session_token = SecureRandom::urlsafe_base64
            user = User.find_by_session_token(session[:token])
            return session_token unless user
        end
    end

    


end
