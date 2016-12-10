# Created with com1001---ruby-assignment.
# User: hhirst
# Date: 2016-12-10
# Time: 04:36 PM
# To change this template use Tools | Templates.
require 'console_splash'
splash = ConsoleSplash.new(15,50)
splash.write_header("Flood It", "Harry Hirst", "0.01")
splash.write_center(-5, "Press Enter to Continue")
splash.write_horizontal_pattern("*")
splash.write_vertical_pattern("*")
splash.splash

puts""
gets.chomp

puts "WELL DONE, you pressed enter"
print "just work"