#=UserRole
# The roles associated with a user.
# A unique compound index on the table ensures that there will be no duplication.
class UserRole < ActiveRecord::Base
  belongs_to :user
  belongs_to :role
  validates_uniqueness_of :user_id, :scope => :role_id
end
