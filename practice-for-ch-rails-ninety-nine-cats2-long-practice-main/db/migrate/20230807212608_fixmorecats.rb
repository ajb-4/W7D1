class Fixmorecats < ActiveRecord::Migration[7.0]
  def change
    remove_column :cats, :owner_id_id
  end
end
