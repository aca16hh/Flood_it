# Created with com1001---ruby-assignment.
# User: hhirst
# Date: 2016-12-10
# Time: 04:36 PM
# To change this template use Tools | Templates.
require 'console_splash'

splash = ConsoleSplash.new(15,50)
splash.write_header("Flood It", "Harry Hirst", "0.03")
splash.write_center(-5, "Press Enter to Continue")
splash.write_horizontal_pattern("*")
splash.write_vertical_pattern("*")
splash.splash

puts""
gets.chomp

puts "WELL DONE, you pressed enter"
def menu(height, width)
  puts "MAIN MENU"
  puts "s = Start game"
  puts "c = change size"
  puts "q = quit"
  puts "High  Score: unavailable"

  print "Please Enter Your Choice: "
  input = gets.chomp.downcase
  if input=="s"
    flood(height, width)
  elsif input=="c"
    print "What is the new height (currently #{height})? "
    height = gets.chomp
    print "What is the new width (currently #{width})? "
    width = gets.chomp
    menu(height, width)
  elsif input=="q"
    puts "Thank you for playing!"
  else
    puts "that's not a command"
    menu(height, width)
  end
end

def flood(height, width)
  board = Array.new[height, width]
  i=0
  j=0
  while(i<height)
    while(j<width)
      board[i, j]=rand(0...5)
      print(board[i, j]+" ")
      j=j+1
    end
    puts""
    i=i+1
  end
end


menu(9, 14)