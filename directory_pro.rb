@students = [] # an empty array accessible to all methods

def print_header
  puts "The students of my cohort at Makers Academy".center(100)
  puts "------------- ".center(100)
end

def print_student_bycohort
  if !@students.empty?
	  #puts "------------------".center(100)
	  sorted = @students.sort {|x,y| x[:cohort] <=> y[:cohort]}
	  sorted.each_with_index do |stud, index|
	    puts "#{index +1}. #{stud[:name]}, #{stud[:hobby]}, #{stud[:country]}, #{stud[:cohort]}".center(100)
	  end
	else puts "You have no students!"
  end
end

def print_footer
  print "Overall, we have #{@students.length} great students. \n"
end

#let's put all students into an array
def input_students
  print "Please enter the name of the students \n"
  print "To finish, just hit return twice at the name \n"
  puts "Please insert the student's name"
  name = STDIN.gets.chomp
  return if name.empty?
  cohort, hobby, country = get_student_details
  #while the name is not empty, repeat this code
  while !name.empty? do
  #add the student hash to the array
    student_inputter(name, cohort, hobby, country)
	  if @students.length > 1
	    print "Now we have #{@students.length} students. \n"
	  else print "Now we have #{@students.length} student. \n"
	  end
	  puts "Please insert the student's name"
	  name = STDIN.gets.chomp
	break if name.empty?
	  cohort, hobby, country = get_student_details
  end	
end

def get_student_details
	puts "Cohort please?"
	cohort = STDIN.gets.chomp
	puts "Are you sure? y/n"
	sure = STDIN.gets.chomp
	if sure == "n"
	  puts "Cohort please?"
	  cohort = STDIN.gets.chomp
	elsif cohort.empty?
	  cohort = "unknown"
	end
	puts "Hobby?"
	hobby = STDIN.gets.chomp
	puts "Country?"
	country = STDIN.gets.chomp
  [cohort, hobby, country]
end

def print_menu
  puts "1. Input the students"
  puts "2. Show the students"
  puts "3. Save the list to students.csv"
  puts "4. Load the list from students.csv"
  puts "9. Exit" #9 because we'll be adding more items
end

def show_students
	print_header
	print_student_bycohort
	print_footer
end

def save_students
  #open the file for writing
  file = File.open("students.csv", "w")
  #iterate over the array of students
  @students.each do |student|
    student_data = [student[:name], student[:hobby], student[:country], student[:cohort]]
    csv_line = student_data.join(",")
    file.puts csv_line
  end
  file.close
end

def student_inputter(name, cohort, hobby, country)
  @students << {:name => name, :cohort => cohort, :hobby => hobby, :country => country}
end

def load_students(filename = "students.csv") # we have given the filename a default value
	file = File.open(filename, "r")
	file.readlines.each do |line|
		name, hobby, country, cohort = line.chomp.split(',') #this is a parallel assignment: we are assigning 4 variables at the same time.
		student_inputter(name, cohort, hobby, country)
	end
	file.close
end

def try_load_students
	filename = ARGV.first #first argument from the command line
  return if filename.nil? #get out of the method if it isn't given
  if File.exists?(filename) #if it exists
  	load_students(filename)
  	puts "\nLoaded #{@students.length} from #{filename} \n\n"
  else # if it doesn't exist
  	puts "\nSorry, #{filename} doesn't exist.\n\n"
  	exit #quit the program
  end
end

def process(selection)
  case selection
  when "1"
  	input_students
  when "2"
  	show_students
  when "3"
  	save_students
  when "4"
  	load_students
  when "9"
  	exit #this will cause the program to terminate
  else
  	puts "I don't know what you meant, try again"
  end
end

def interactive_menu
  loop do
    #1. print the menu and ask the user what to do
    print_menu
    #2. read the input and save it into a variable & #3. do what the user has asked    
    process(STDIN.gets.chomp)
    end
end 


#nothing happens until we call the methods
try_load_students
interactive_menu 



	

