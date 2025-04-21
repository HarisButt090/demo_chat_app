module Types
  module Users
    class LoginAttributes < Types::BaseInputObject
      argument :email, String, required: true
      argument :type, String, required: true
      argument :password, String, required: true
      argument :remember_me, Boolean, required: false
    end
  end
end