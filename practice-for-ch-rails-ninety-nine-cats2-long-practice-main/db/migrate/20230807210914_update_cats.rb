class UpdateCats < ActiveRecord::Migration[7.0]
  def change
    add_reference :cats, :owner_id, null: false, foreign_key: {to_table: :users}

  end
end
