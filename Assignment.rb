# Created with com1001---ruby-assignment.
# User: hhirst
# Date: 2016-12-10
# Time: 04:36 PM
# To change this template use Tools | Templates.
require 'console_splash'

splash = ConsoleSplash.new(15,50)
splash.write_header("Flood It", "Harry Hirst", "0.02")
splash.write_center(-5, "Press Enter to Continue")
splash.write_horizontal_pattern("*")
splash.write_vertical_pattern("*")
splash.splash

puts""
gets.chomp

puts "WELL DONE, you pressed enter"
def menu
  puts "MAIN MENU"
  puts "s = Start game"
  puts "c = change size"
  puts "q = quit"

  print "Please Enter Your Choice: "
  input = gets.chomp.downcase
  if input=="s"
    menu
  elsif input=="c"
    menu
  elsif input=="q"
    puts "Thank you for playing!"
  else
    puts "that's not a command"
    menu
  end
end


menu