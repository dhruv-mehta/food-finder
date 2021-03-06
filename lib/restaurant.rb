require 'support/number_helper'

class Restaurant
include NumberHelper	

	@@filepath=nil
	attr_accessor :name, :cusine,:price

	def self.filepath=(path=nil)
		@@filepath=File.join(APP_ROOT,path)
		
	end

	def self.file_usable?

		return false unless  @@filepath
		return false unless File.exists?(@@filepath)
		return false unless File.readable?(@@filepath)
		return false unless File.writable?(@@filepath)
		return true
			
	end
			
	def self.file_exists?

		if @@filepath && File.exists?(@@filepath)
			
			return true 

		else 
			return false
		end

	end


	def self.create_file
			File.open(@@filepath, "w") unless file_exists?
			return file_usable?
	end	

	def self.saved_restaurant

		restaurant=[]
		if file_usable?
		file=File.new(@@filepath,'r')
		file.each_line do |line|
		restaurant << Restaurant.new.import_line(line.chomp)
		end	
     end
     return restaurant

	end

	def self.build_from_questions
		args={}
		print "Restaurant name: "
		args[:name]=gets.chomp.strip
		print "Restaurant type : "
		args[:cusine]=gets.chomp.strip
		print "average price : "
		args[:price]=gets.chomp.strip
		return self.new(args)
		end

	def initialize(args={})
		@name	=	args[:name] 	|| "" 
		@cusine	=args[:cusine] 	|| ""
		@price	=	args[:price] 	|| ""
	end

	def import_line(line)
		line_array=line.split("\t")
		@name,@cusine,@price =line_array
		return   self
	end

	def save
		return false unless Restaurant.file_usable
		File.open(@@filepath, "a") do |file| 
			file.puts "#{[@name,@cusine,@price].join("\t")}\n"
		
		return true
			
		end
		
	end

	def formatted_price
		number_to_currency(@price)
	end
end