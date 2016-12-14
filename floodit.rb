# Created with com1001---ruby-assignment.
# User: hhirst
# Date: 2016-12-10
# Time: 04:36 PM
# To change this template use Tools | Templates.
require 'console_splash'
require 'colorize'

#Here I initialize and apply the splash scrren upon start up
splash = ConsoleSplash.new(15,50)
splash.write_header("Flood It", "Harry Hirst", "0.99")
splash.write_center(-5, "Press Enter to Continue")
splash.write_horizontal_pattern("*")
splash.write_vertical_pattern("*")
splash.splash

#This places a line to make it look neater then when the user presses enter, the menu method is activated
puts""
gets.chomp

def menu(height, width, high)
  #I list the options for the user's benefit
  puts "main menu"
  puts "s = Start game"
  puts "c = change size"
  puts "q = quit"
  #This keeps track of the high score unless it is the first game in which case it displays a different message
  if high==999
    puts "No games played yet."
  elsif high<999
    puts "Best game: #{high} turns"
  end
  #here, the user can enter the letter corespondin to which option they want to select
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
    abort("Thank you for playing")
  #this else clause helps catch if the user mis-types a command and restarts the menu
  else
    puts "that's not a command"
    menu(height, width, high)
  end
end

#this activates when the user starts a new game and draws out a canvas of random dots
def get_board(height, width, high)
  #I initialize my arrays. Board contains the colours to be drawn to the screen while group contains the player's area and all the adjacent same coloured blocks within
  board = Array.new(height){Array.new(width, 0)}
  group = Array.new(height){Array.new(width, 0)}
  #creates the initial play area of one block
  group[0][0]=1
  colors = [":red", ":green", ":blue", ":cyan", ":magenta", ":yellow"]
  i=0
  j=0
  #I pick random colours to assign to each coordinate in the array.
  until(i>=height) do
    while(j<width)
      random=colors[rand(0...6)]
      if(random==":green")
        board[i][j]=":green"
      elsif random==":red"
        board[i][j]=":red"
      elsif random==":blue"
        board[i][j]=":blue"
      elsif random==":yellow"
        board[i][j]=":yellow"
      elsif random==":cyan"
        board[i][j]=":cyan"
      elsif random==":magenta"
        board[i][j]=":magenta"
      end
      #moves the loop to the next iteration
      j=j+1
    end
    j=0
    i=i+1
  end
  #calls the update method instaed of draw board to check if there are any adjacent squares which by chance have the same colour
  update(height, width, high, 0, board, group)
end

def draw_board(height, width, high, turns, board, group)
  i=0
  j=0
  #goes through the array and prints spaces with an appropriate background colour for each coordinate
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
  play(height, width, high, turns, board, group)
end

def play(height, width, high, turns, board, group)
  i=0
  j=0
  completion=0
  puts""
  #adds to completion allowing me to calculate percentage later
  while(i<height)
    while(j<width)
      completion=completion+(group[i][j].to_i)
      j=j+1
    end
    j=0
    i=i+1
  end
  #prints relevant data to gameplay
  puts "number of turns: #{turns}"
  puts "Current completion: #{(completion*100)/(height*width)}%"
  print "Choose a colour: "
  #reads user input and either quits or changes the top left block to their colour
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
    #restarts the round if the user mistypes something
    puts "That's not a valid option, please try again"
    play(height, width, high, turns, board, group)
  end
  update(height, width, high, turns, board, group)
end
      
def update(height, width, high, turns, board, group)
  i=0
  j=0
  base=board[0][0]
  #keeps the user from going on in the game forever
  if turns>=999
    puts "YOU LOSE"
    menu(height, width, high)
  end
  #complicated method which effectively checks all the blocks adjacent to those which are in the selected group to see if they are the same colour and if they are, it adds them to the group
  while(i<height)
    while(j<width)
      if(group[i][j]==1)
        board[i][j]=base
        #these allow me to check for multiple new blocks in a line together
        iPlus=i+1
        jPlus=j+1
        iMinus=i-1
        jMinus=j-1
        #each of these checks analyses whether there are any adjacent blocks of the same colour which need to be added to the player's group 
        if(iPlus<height)
          if(board[iPlus][j]==base)
            group[iPlus][j]=1
          end
        end
        if jPlus<width
          if(board[i][jPlus]==base)
            group[i][jPlus]=1
          end
        end
        #the pluses didn't need an extra loop as the program would naturally come to their later adjacent colours, the minuses will need one to check if there are multiple blocks to be added to the group
        if iMinus>=0
          if board[iMinus][j]==base
            group[iMinus][j]=1
          end
          until(board[iMinus][j]!=base||iMinus<0) do
            group[iMinus][j]=1
            iMinus=iMinus-1
          end
        end
        if jMinus>=1
          if board[i][jMinus]==base
            group[i][jMinus]=1
          end
          until(board[i][jMinus]!=base||jMinus<0) do
            group[i][jMinus]=1
            jMinus=jMinus-1
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
        
#this method checks if the array is all the same colour. If it is, the user wins
def check(height, width, high, turns, board, group)
  i=0
  j=0
  puts""
  base=board[0][0]
  #checks every block in the board. If any of them are a different colour, the next round starts otherwise the user wins.
  while(i<height)
    while(j<width)
      if(base!=board[i][j])
        draw_board(height, width, high, turns, board, group)
      end
      j=j+1
    end
    j=0
    i=i+1
  end
  puts "Congratulations! you won after #{turns}"
  #updates the high score
  if(turns<high)
    high = turns
    puts "Well Done! You got a new high score."
  end
  puts "press enter to return to main menu"
  #waits for the user to return
  gets
  menu(height, width, high)
end

#calls the start of the program
menu(9, 14, 999)