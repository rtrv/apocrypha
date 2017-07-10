class CreateBooks < ActiveRecord::Migration[5.0]
  def change
    create_table :books do |t|
      t.string :name, null: false
      t.string :isbn, null: false, unique: true
      t.integer :quantity, null: false, default: 0

      t.timestamps
    end

    boost_fts!
    add_constraints!
  end

  private

  def boost_fts!
    add_column :books, :tsv, :tsvector
    add_index :books, :tsv, using: :gin

    execute <<-SQL
      CREATE TRIGGER tsvectorupdate BEFORE INSERT OR UPDATE
      ON books FOR EACH ROW EXECUTE PROCEDURE
      tsvector_update_trigger(
        tsv, 'pg_catalog.english', name
      );
    SQL
  end

  def add_constraints!
    # Limit quantity to be positive
    execute <<-SQL
      ALTER TABLE books ADD CONSTRAINT quantity CHECK (quantity >= 0);
    SQL
  end
end
