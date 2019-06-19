class HardAi
  def calc_best(board)
    choice = nil
    value = -100
    board.each do |pos|
      if pos.nil?
        pos_val = min_max(pos, board, "1")
        if pos_val > value
          choice = pos
          value = pos_val
        end
      end
    end

    best_choice = nil
    choices.each do |choice|
      return 10 if Tictactoe.new.won?(choice)
      return 0 if Tictactoe.new.draw?(choice)
      return calc_best(choice) - 1
    end
  end


  def min_max(choice, board, player)
    board = board.dup
    board[choice] = player
    if player == "1"
      return 10 if won_by?(board, player)
    else
      return -10 if won_by(board, player)
    end
    return 0 if draw?(board)
    best_move = -100
    board.each do |pos|
      if pos.nil?
        move = min_max(pos, board, (player == "1" ? "0" : "1")) - 1
        best_move = move if move > best_move
      end
    end
    return best_move
  end

  def draw?(board)
    board.none?(&:nil?)
  end

  def won_by?(boxes, player)
    i = player
    arr = []
    arr.<<(boxes[0] == i && boxes[0] == boxes[1] && boxes[0] == boxes[2])
       .<<(boxes[0] == i && boxes[0] == boxes[3] && boxes[0] == boxes[6])
       .<<(boxes[0] == i && boxes[0] == boxes[4] && boxes[0] == boxes[8])
       .<<(boxes[1] == i && boxes[1] == boxes[4] && boxes[1] == boxes[7])
       .<<(boxes[2] == i && boxes[2] == boxes[4] && boxes[2] == boxes[6])
       .<<(boxes[2] == i && boxes[2] == boxes[5] && boxes[2] == boxes[8])
       .<<(boxes[3] == i && boxes[3] == boxes[4] && boxes[3] == boxes[5])
       .<<(boxes[6] == i && boxes[6] == boxes[7] && boxes[6] == boxes[8])

    arr.any?
  end
end
