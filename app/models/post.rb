class Post < ActiveRecord::Base
  cattr_reader :per_page
  @@per_page = 1
end
