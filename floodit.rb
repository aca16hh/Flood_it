# Created with com1001---ruby-assignment.
# User: hhirst
# Date: 2016-12-10
# Time: 04:36 PM
# To change this template use Tools | Templates.
require 'console_splash'#
require 'colorize'

splash = ConsoleSplash.new(15,50)
splash.write_header("Flood It", "Harry Hirst", "0.03")
splash.write_center(-5, "Press Enter to Continue")
splash.write_horizontal_pattern("*")
splash.write_vertical_pattern("*")
splash.splash
score=0

puts""
gets.chomp

puts "WELL DONE, you pressed enter"
def menu(height, width, score)
  puts "MAIN MENU"
  puts "s = Start game"
  puts "c = change size"
  puts "q = quit"
  if score==0
    puts "No games played yet."
  elsif score>0
    puts "Best game: #{score} turns"
  end

  print "Please Enter Your Choice: "
  input = gets.chomp.downcase
  if input=="s"
    puts""
    get_board(height, width, score)
  elsif input=="c"
    print "What is the new height (currently #{height})? "
    height = gets.chomp.to_i
    print "What is the new width (currently #{width})? "
    width = gets.chomp.to_i
    menu(height, width, score)
  elsif input=="q"
    puts "Thank you for playing!"
  else
    puts "that's not a command"
    menu(height, width, score)
  end
end


def get_board(height, width, score)
  score=score+1
  board = Array.new(height){Array.new(width, 0)}
  colors = [":red", ":green", ":blue", ":cyan", ":magenta", ":yellow"]
  i=0
  j=0
  until(i>=height) do
    while(j<width)
      rand=colors[rand(0...6)]
      if rand==":red"
        print("  ".colorize(:background => :red))
        board[i][j]=":red"
      elsif rand==":blue"
        print("  ".colorize(:background => :blue))
        board[i][j]=":blue"
      elsif rand==":green"
        print("  ".colorize(:background => :green))
        board[i][j]="green"
      elsif rand==":yellow"
        print("  ".colorize(:background => :yellow))
        board[i][j]=":yellow"
      elsif rand==":cyan"
        print("  ".colorize(:background => :cyan))
        board[i][j]=":cyan"
      elsif rand==":magenta"
        print("  ".colorize(:background => :magenta))
        board[i][j]=":magenta"
      end
      j=j+1
    end
    puts""
    j=0
    i=i+1
  end
  menu(height, width, score)
end

menu(9, 14, score)