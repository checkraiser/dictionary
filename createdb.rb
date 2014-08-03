require "sqlite3"

# Open a database
db = SQLite3::Database.new "ja7.db"

# Create a database
rows = db.execute <<-SQL
  create table japanese (
    id int,
    origin text,
	meaning text    
  );
SQL
