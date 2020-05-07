class TicTacToe 
  
  WIN_COMBINATIONS = [
  [0,1,2], # Top row
  [3,4,5],  # Middle row
  [6,7,8],
  [0,3,6],
  [1,4,7],
  [2,5,8],
  [0,4,8],
  [6,4,2]
  # et cetera, creating a nested array for each win combination
  ]
  
  def initialize
    @board = Array.new(9, " ")
  end
  
  def display_board
    puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
    puts "-----------"
    puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
    puts "-----------"
    puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
  end
  
  def input_to_index(input)
    input.to_i - 1 # -1 because arrays start at 0
  end
  
  # default token is X if none given
  def move(index, token="X")
    @board[index] = token
  end
  
  # checks against @board to see if index is already preoccupied
  def position_taken?(index)
    !(@board[index] == " " || @board[index].nil?)
  end
  
  # checks if index is a valid move
  def valid_move?(index)
    if ( !position_taken?(index) && index.between?(0,8) )
      return true
    else
      return false
    end
  end
  
  # For every token X || O increment turn counter and return
  def turn_count
    count = 0
    for i in 0..@board.length-1
      if @board[i] == "X" || @board[i] == "O"
        count += 1
      end
    end
    return count
  end
  
  # if current turn count is even, next token is X
  # if current turn count is odd, next token is O
  def current_player
    total_turns = turn_count # gets the total amount of turns taken SO FAR
    token = nil 
    if total_turns % 2 == 0
      token = "X"
    else
      token = "O"
    end
    return token
  end
  
  def turn
    puts "Enter a board space 1-9:"
    input = gets.chomp
    index = input_to_index(input)
    if valid_move?(index)
      token = current_player
      move(index, token)
      display_board
    else
      turn # prompts user for next input if board space inputted is not valid
    end
  end
  
  # for each combo within win_combos check if these positions exist within the current @board state
  def won?
    WIN_COMBINATIONS.each do |combo| # [1, 2, 3] @board[1, 2, 3]
      # get all 3 indices of winning combo
      win_index_0 = combo[0]
      win_index_1 = combo[1]
      win_index_2 = combo[2]
      
      # check pos of @board for each of these indices
      board_pos_0 = @board[win_index_0]
      board_pos_1 = @board[win_index_1]
      board_pos_2 = @board[win_index_2]
      
      if ( board_pos_0 == "X" && board_pos_1 == "X" && board_pos_2 == "X" ) || ( board_pos_0 == "O" && board_pos_1 == "O" && board_pos_2 == "O" )
        return combo
      end
    end
    return false # else if no winning combo found, return false
  end
  
  # check if @board is filled up
  def full?
    full = true
    for i in 0..@board.length-1
      if @board[i] == " "
        full = false
      end
    end
    return full
  end
  
  def draw?
    (!won? && full?) ? true : false
  end
  
  def over?
    won? || full? ? true : false
  end
  
  def winner
    winner_combo = won?
    if winner_combo == false
      return nil
    else
      # ternary operator didn't work here... 
      if @board[winner_combo[0]] == "X"
        return "X"
      else
        return "O"
      end
    end
  end
  
  def play
    until over? || draw? == true
      turn
    end
    
    if won?
      puts "Congratulations #{winner}!"
    elsif draw?
      puts "Cat's Game!"
    end
  end
      
end

