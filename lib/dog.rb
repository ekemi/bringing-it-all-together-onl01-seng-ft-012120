
require "pry"
class Dog 
  
  attr_accessor :name,:breed,:id
def initialize(name:name,id:id,breed:breed)
  
  @name = name
  
  @id = id
  @breed = breed
  
    
  end
  def self.create_table
  sql = <<-SQL
    
         CREATE TABLE dogs(id INTEGER PRIMARY KEY,name TEXT, breed TEXT);
    SQL
    DB[:conn].execute(sql)
  end
  def self.drop_table
    
    sql = <<-SQL
    
    DROP TABLE dogs
    SQL
    
    DB[:conn].execute(sql)
    
  end
    def save
      
     if self.id
       self.update
       
     else 
       sql = <<-SQL
       
       INSERT INTO dogs(name, breed)
       VALUES(?, ?)
       
       SQL
      DB[:conn].execute(sql, self.name, self.breed) 
      @id = DB[:conn].execute("SELECT last_insert_rowid() FROM dogs")[0][0]
      
      self
      
      # binding.pry
       
      end 
      
    end
    
    def update
      
   sql = <<-SQL
   
   UPDATE SET name = ? , breed = ? , id = ?
   
   SQL
     DB[:conn].execute(sql,self.name,self.breed,self.id) 
    end
    
    def self.create ()#name:name,breed:breed)
      
      new_object = Dog.new
      new_object.save
      new_object
      
      
    end
end