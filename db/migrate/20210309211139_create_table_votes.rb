class CreateTableVotes < ActiveRecord::Migration[5.2]
  def change
    create_table :votes do |t|
      t.integer :value
      t.references :votable, polymorphic: true

      t.timestamps
    end
  end
end
