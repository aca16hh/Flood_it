# Created with com1001---ruby-assignment.
# User: hhirst
# Date: 2016-12-10
# Time: 04:36 PM
# To change this template use Tools | Templates.
require 'console_splash'
require 'colorize'

splash = ConsoleSplash.new(15,50)
splash.write_header("Flood It", "Harry Hirst", "0.03")
splash.write_center(-5, "Press Enter to Continue")
splash.write_horizontal_pattern("*")
splash.write_vertical_pattern("*")
splash.splash
high = 0

puts""
gets.chomp

def menu(height, width, high)
  puts "MAIN MENU"
  puts "s = Start game"
  puts "c = change size"
  puts "q = quit"
  if high==0
    puts "No games played yet."
  elsif high>0
    puts "Best game: #{high} turns"
  end

  print "Please Enter Your Choice: "
  input = gets.chomp.downcase
  if input=="s"
    puts""
    get_board(height, width, high)
  elsif input=="c"
    print "What is the new height (currently #{height})? "
    height = gets.chomp.to_i
    print "What is the new width (currently #{width})? "
    width = gets.chomp.to_i
    menu(height, width, high)
  elsif input=="q"
    puts "Thank you for playing!"
    nil
  else
    puts "that's not a command"
    menu(height, width, high)
  end
end


def get_board(height, width, high)
  board = Array.new(height){Array.new(width, 0)}
  group = Array.new(height){Array.new(width, 0)}
  colors = [":red", ":green", ":blue", ":cyan", ":magenta", ":yellow"]
  i=0
  j=0
  until(i>=height) do
    while(j<width)
      random=colors[rand(0...6)]
      if(random==":green")
        print("  ".colorize(:background => :green))
        board[i][j]=":green"
      elsif random==":red"
        print("  ".colorize(:background => :red)) 
        board[i][j]=":red"
      elsif random==":blue"
        print("  ".colorize(:background => :blue))
        board[i][j]=":blue"
      elsif random==":yellow"
        print("  ".colorize(:background => :yellow))
        board[i][j]=":yellow"
      elsif random==":cyan"
        print("  ".colorize(:background => :cyan))
        board[i][j]=":cyan"
      elsif random==":magenta"
        print("  ".colorize(:background => :magenta))
        board[i][j]=":magenta"
      end
      j=j+1
    end
    puts""
    j=0
    i=i+1
  end
  update(height, width, high, 0, board, group)
end

def draw_board(height, width, high, turns, complete, board, group)
  i=0
  j=0
  puts"devil child"
  while(i<height)
    while(j<width)
      if(board[i][j]==":green")
        print("  ".colorize(:background => :green))
      elsif(board[i][j]==":red")
        print("  ".colorize(:background => :red))
      elsif(board[i][j]==":blue")
        print("  ".colorize(:background => :blue))
      elsif(board[i][j]==":yellow")
        print("  ".colorize(:background => :yellow))
      elsif(board[i][j]==":magenta")
        print("  ".colorize(:background => :magenta))
      elsif(board[i][j]=":cyan")
        print("  ".colorize(:background => :cyan))
      end
      j=j+1
    end
    puts""
    j=0
    i=i+1
  end
  play(height, width, high, turns, complete, board, group)
end

def play(height, width, high, turns, complete, board, group)
  i=0
  j=0
  percent = (complete/(height*width))*100
  puts "number of turns: #{turns}"
  puts "Current completion: #{percent}%"
  print "Choose a colour: "
  input=gets.chomp
  if input=="q"
    menu(height, width, high)
  elsif input=="r"
    turns=turns+1
    board[0][0] =":red"
  elsif input=="g"
    turns=turns+1
    board[0][0] =":green"
  elsif input=="b"
    turns=turns+1
    board[0][0] =":blue"
  elsif input=="y"
    turns=turns+1
    board[0][0] =":yellow"
  elsif input=="c"
    turns=turns+1
    board[0][0] =":cyan"
  elsif input=="m"
    turns=turns+1
    board[0][0] =":magenta"
  else
    puts "That's not a valid option, please try again"
    play(height, width, high, turns, complete, board, group)
  end
  update(height, width, high, turns, board, group)
end
      
def update(height, width, high, turns, board, group)
  i=0
  j=0
  group[0][0]=1
  base=board[0][0]
  while(i<height)
    while(j<width)
      if(group[i][j]==1)
        board[i][j]=base
        iPlus=i+1
        jPlus=j+1
        iMinus=i-1
        jMinus=j-1
        if(iPlus<height)
          if(board[iPlus][j]==base)
            group[iPlus][j]=1
            board[iPlus][j]=base
          end
        end
        if jPlus<width
          if(board[i][jPlus]==base)
            group[i][jPlus]=1
            board[i][jPlus]=base
          end
        end
        if iMinus>=1
          until(board[iMinus][j]!=base) do
            if iMinus>=1
              group[iMinus][j]=1
              board[iMinus][j]=base
              iMinus=iMinus-1
            end
          end
        end
        if jMinus>=1
          if(board[i][jMinus]==base)
            if jMinus>=1
              group[i][jMinus]=1
              board[i][jMinus]=base
              jMinus=jMinus-1
            end
          end
        end
      end
      j=j+1
    end
    j=0
    i=i+1
  end
  check(height, width, high, turns, board, group)
end
        

def check(height, width, high, turns, board, group)
  i=0
  j=0
  complete=0
  base=board[0][0]
  while(i<height)
    while(j<width)
      if(base!=board[i][j])
        if turns>0
          draw_board(height, width, high, turns, complete, board, group)
        elsif turns==0
          play(height, width, high, turns, complete, board, group)
        end
      end
      j=j+1
      complete=complete+1
    end
    j=0
    i=i+1
  end
  puts "Congratulations, you won!"
  if(turns<high)
    high = turns
    puts "Well Done! You got a new high score."
  end
  menu(height, width, high)
end
    
menu(9, 14, 0)