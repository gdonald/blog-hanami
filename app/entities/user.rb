# frozen_string_literal: true

require 'bcrypt'

module Blog
  module Entities
    class User
      include BCrypt
      include Deps['persistence.rom']

      attr_reader :password

      attr_accessor :fname,
                    :lname,
                    :email,
                    :password_confirmation,
                    :p_salt,
                    :p_hash

      def initialize(attrs = {})
        @fname = attrs[:fname]
        @lname = attrs[:lname]
        @email = attrs[:email]&.downcase
        self.password = attrs[:password]
        @password_confirmation = attrs[:password_confirmation]
      end

      def create
        return unless valid?

        users = Hanami.app['persistence.rom'].relations[:users]
        created_at = updated_at = Time.now
        users.insert(fname:, lname:, email:, p_hash:, p_salt:, updated_at:, created_at:)
      end

      def update
        return unless valid?

        users = Hanami.app['persistence.rom'].relations[:users]
        updated_at = Time.now
        users.update(fname:, lname:, email:, p_hash:, p_salt:, updated_at:)
      end

      def password=(passwd)
        password = passwd
        return if passwd.nil? || passwd.empty?
    
        self.p_salt = User.salt
        self.p_hash = User.hash_password(password, p_salt)
      end

      def self.authenticate(email, password)
        user = rom.relations[:users].by_email(email&.downcase).one
        return nil if user.nil?
        return user if User.hash_password(password, user.p_salt) == user.p_hash
    
        nil
      end

      def self.salt
        BCrypt::Engine.generate_salt
      end
    
      def self.hash_password(password, salt)
        BCrypt::Engine.hash_secret(password, salt)
      end

      private

      def valid?
        return false unless valid_email?
        return false unless valid_password_confirmation?

        true
      end

      def valid_email?
        unless email.match?(/\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i)
          errors[:email] = 'is invalid'
          return false
        end
    
        true
      end

      def valid_password_confirmation?
        password == password_confirmation
      end
    end
  end
end