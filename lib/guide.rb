require 'restaurant'

class Guide

	class Config
		@@actions=['list','find','add','quit']
		def self.actions;@@actions;end
			
		
			
	end

	def initialize(path=nil)

		Restaurant.filepath= path
		
			
			if Restaurant.file_usable?
		
				puts "found restaurant file"

			elsif Restaurant.create_file
				puts "created restaurant file.."
			else
				puts "exiting.\n\n"
				exit!	
			end
				
	end
	
	def launch!

		introduction
				result=nil
				until result == :quit
					
			
			
					action=get_action
					result=do_action(action)
	
				end

		conclusion

	end

	def get_action

		action=nil;
		until Guide::Config.actions.include?(action)

			puts "action:"+Guide::Config.actions.join(" , ")if action
					puts "enter your choice  :: "
					response=gets.chomp.downcase
					action=response
		end
					return action
					
	end

	def do_action(action)
		
		case action 

		when 'list'
				list
		when 'find'
				puts "finding..."
		when 'add'
				add_resoturant
		when 'quit'
				return :quit
		else
			puts "\n invalid command to run"
		end
	end

	def add_resoturant
		puts "\n adding a restourant \n\n".upcase
		
		restaurant=Restaurant.build_from_questions

		if restaurant.save
			puts "\n Restaurant added\n\n"
		else 
			puts ":error"
		end
	end

		def list

			output_action_header("listing restaurant")
			restaurant=Restaurant.saved_restaurant
			output_restaurant_table(restaurant)
		end

	def introduction

		puts "\n\n<< Welcome to the food finder >>\n\n"
		puts "this is an interactive way to find your food \n\n"
	end

	def conclusion

		
		puts "\n << have a great day ahed. >>\n\n\n"
	end

	private

	def output_action_header(text)
		puts "\n{text.upcase.center(60)}\n\n"
	end

	def output_restaurant_table(restaurant=[])
	print "" + "name".ljust(30)
	print "" + "cusine".ljust(20)
	print "" + "price".rjust(6) + "\n"
	puts "-" *60
	restaurant.each do |rest|
		line=" " << rest.name.ljust(30)
		line<<" " << rest.cusine.ljust(20)
		line<<" " << rest.formatted_price.rjust(6)

		puts line
	end
	puts "mo limiting found" if restaurant.empty?
	puts "-" * 60

		
	
	


	end

end