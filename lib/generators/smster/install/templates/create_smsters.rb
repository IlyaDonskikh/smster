class CreateSmsters< ActiveRecord::Migration
  def up
    create_table :smsters do |t|
      t.string :text
      t.string :name
      t.string :from
      t.string :to
      t.string :code
      t.string :type
      t.integer :status

      t.timestamps
    end
  end

  def down
    drop_table :smsters
  end
end