#=UserRole
# The roles associated with a user.
# A unique compound index on the table ensures that there will be no duplication.
class UserRole < ActiveRecord::Base
  belongs_to :user
  belongs_to :role
end
