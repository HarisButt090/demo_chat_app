module Types
  module Messages
    class ChatType < Types::BaseObject
      field :id, ID, null: false
      field :name, String, null: false
    end
  end
end