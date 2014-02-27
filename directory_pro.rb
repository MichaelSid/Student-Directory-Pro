@students = [] # an empty array accessible to all methods

#let's put all students into an array
def input_students
  print "Please enter the name of the students \n"
  print "To finish, just hit return twice at the name \n"
  #create an empty array
  #students = []           ======> we don't need it anymore because it's a global variable
  #get the first name
  name = gets.chomp
  puts "Cohort please?"
  cohort = gets.sub("\n"," ")
  puts "Are you sure? y/n"
  sure = gets.chomp
  if sure == "n"
    puts "Cohort please?"
	  cohort = gets.chomp
  elsif cohort.empty?
    cohort = "unknown"
  end
  puts "Hobby?"
  hobby = gets.chomp
  puts "Country?"
  country = gets.chomp
  #while the name is not empty, repeat this code
  while !name.empty? do
  #add the student hash to the array
    @students << {:name => name, :cohort => cohort, :hobby => hobby, :country => country}
	  if @students.length > 1
	    print "Now we have #{@students.length} students. \n"
	  else print "Now we have #{@students.length} student. \n"
	  end
	  name = gets.chomp
	break if name.empty?
	  puts "Cohort please?"
	  cohort = gets.chomp
	  puts "Are you sure? y/n"
	  sure = gets.chomp
	  if sure == "n"
	    puts "Cohort please?"
	    cohort = gets.chomp
	  elsif cohort.empty?
	    cohort = "unknown"
	  end
	  puts "Hobby?"
	  hobby = gets.chomp
	  puts "Country?"
	  country = gets.chomp
  end	
  #return the array of students
  #@students
end



def interactive_menu
  loop do
    #1. print the menu and ask the user what to do
    print_menu
    #2. read the input and save it into a variable & #3. do what the user has asked    
    process(gets.chomp)
  end
end 

def print_menu
  puts "1. Input the students"
  puts "2. Show the students"
  puts "9. Exit" #9 because we'll be adding more items
end

def show_students
	print_header
	print_student_bycohort
	print_footer
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

def process(selection)
  case selection
  when "1"
  	input_students
  when "2"
  	show_students
  when "9"
  	exit #this will cause the program to terminate
  else
  	puts "I don't know what you meant, try again"
  end
end



def print_header
  puts "The students of my cohort at Makers Academy".center(100)
  puts "------------- ".center(100)
end

def print_students
  if !@students.empty?
	  i = 0
	  while i < @students.length
	    stud = @students[i]
	    puts "#{stud[:name]}, #{stud[:hobby]}, #{stud[:country]}, #{stud[:cohort]}".center(100) 
	    i += 1
	  end
  else puts "You have no students!"
  end
end





def print_footer
  print "Overall, we have #{@students.length} great students. \n"
end

#nothing happens until we call the methods
interactive_menu



	

