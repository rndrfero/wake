class Piece < ActiveRecord::Base
  
  belongs_to :thing
  
  attr_accessible :int, :str
  
  validates_presence_of :str, :int
  
end
