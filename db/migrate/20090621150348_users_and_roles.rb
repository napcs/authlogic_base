class UsersAndRoles < ActiveRecord::Migration
  def self.up
    
    create_table :users do |t|
      t.string    :login,               :null => false                # optional, you can use email instead, or both
      t.string    :email,               :null => false                # optional, you can use login instead, or both
      t.string    :crypted_password,    :default => nil, :null => true
      t.string    :password_salt,       :default => nil, :null => true                # optional, but highly recommended
      t.string    :persistence_token,   :null => false                # required
      t.string    :single_access_token, :null => false                # optional, see Authlogic::Session::Params
      t.string    :perishable_token,    :null => false                # optional, see Authlogic::Session::Perishability
      t.boolean   :active,              :null => false, :default => false
      # Magic columns, just like ActiveRecord's created_at and updated_at. These are automatically maintained by Authlogic if they are present.
      t.integer   :login_count,         :null => false, :default => 0 # optional, see Authlogic::Session::MagicColumns
      t.integer   :failed_login_count,  :null => false, :default => 0 # optional, see Authlogic::Session::MagicColumns
      t.datetime  :last_request_at                                    # optional, see Authlogic::Session::MagicColumns
      t.datetime  :current_login_at                                   # optional, see Authlogic::Session::MagicColumns
      t.datetime  :last_login_at                                      # optional, see Authlogic::Session::MagicColumns
      t.string    :current_login_ip                                   # optional, see Authlogic::Session::MagicColumns
      t.string    :last_login_ip                                      # optional, see Authlogic::Session::MagicColumns
      t.timestamps
    end
    

    create_table :roles do |t|
      t.string :name
      t.timestamps
    end
    
    create_table :user_roles do |t|
      t.column :user_id, :integer
      t.column :role_id, :integer
      t.column :created_at, :datetime
    end

    add_index :user_roles, [:user_id, :role_id], :unique => true
    add_index :roles, :name

  end

  def self.down
    remove_index :roles, :name
    remove_index :user_roles, :column => [:user_id, :role_id]
    drop_table "users"
    drop_table "roles"
  end
end
