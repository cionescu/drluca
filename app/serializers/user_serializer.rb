class UserSerializer < ActiveModel::Serializer
  attributes :name, :quiz_id, :status
end
