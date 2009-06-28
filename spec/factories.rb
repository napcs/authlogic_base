Factory.define :user do |u|
  u.login "user"
  u.email "user@socialbrokerage.com"
  u.password "socialbrokerage"
  u.password_confirmation "socialbrokerage"
end

Factory.define :admin, :parent => :user do |a|
  a.login "admin"
  a.email "admin@socialbrokerage.com"
  a.roles {|factory| [factory.association(:admin_role)]}
  a.active true
end

Factory.define :active_user, :parent => :user do |u|
  u.active true
end

Factory.define :organizer, :parent => :active_user do |u|
  u.roles {|factory| [factory.association(:organizer_role)]}
  u.login "organizer"
  u.email "organizer@socialbrokerage.com"
end

Factory.define :merchant, :parent => :active_user do |u|
  u.roles {|factory| [factory.association(:merchant_role)]}
  u.login "merchant"
  u.email "merchant@socialbrokerage.com"
end

Factory.define :user_waiting_activation, :parent => :user do |u|
  u.active false
  u.perishable_token  "abcd"
end

Factory.define :user_requesting_password, :parent=>:user do |u|
  u.perishable_token  "abcd"
end

Factory.define :role do |r|
  r.name "user"
end

Factory.define :admin_role, :parent => :role do |r|
  r.name "admin"
end

Factory.define :organizer_role, :parent => :role do |r|
  r.name "organizer"
end

Factory.define :merchant_role, :parent => :role do |r|
  r.name "merchant"
end
