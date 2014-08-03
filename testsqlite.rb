require 'sqlite3'

db = SQLite3::Database.new "ja7.db"




	  
term='A'
db.execute( "select * from japanese where origin = '#{term}';") do |row|		
	puts row.inspect
end