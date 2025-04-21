# app/graphql/concerns/user_type_resolver.rb
module UserTypeResolver
    extend ActiveSupport::Concern
  
    def resolve_user_class(type)
      case type
      when "instructor"
        Users::Instructor
      when "learner"
        Users::Learner
      when "admin"
        Users::Admin
      when "super_admin"
        Users::SuperAdmin
      else
        raise 'Invalid user type specified'
      end
    end
end
  