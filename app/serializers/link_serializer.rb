class LinkSerializer < ActiveModel::Serializer
  attributes :id, :url, :title, :read, :user_id, :html_title, :html_h1
end
