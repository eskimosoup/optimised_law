class CreateWillowTrees < ActiveRecord::Migration
  def up
    create_table :willow_branches  do |t|
      t.column :tree, :string
      t.column :name, :string
      t.column :position, :integer, :default => 0
      t.column :ancestry, :string
      t.column :ancestry_depth, :integer, :default => 0
      t.column :positions_depth_cache, :string
      t.column :leaf_id, :integer
      t.column :leaf_type, :string
      t.column :sturdy, :boolean, :default => false
      t.column :can_have_children, :boolean, :default => false
      t.column :primary, :boolean, :default => false
      t.column :access_key, :string
    end
    
    create_table :willow_leaves  do |t|
      t.column :name, :string
      t.column :route, :string
      t.column :type, :string
    end
    
    add_index :willow_branches, :ancestry
  end
  
  def down
    drop_table :willow_branches
    drop_table :willow_leaves
  end
end
