# Define board dimensions
BOARD_WIDTH <- 10
BOARD_HEIGHT <- 10

# Define ship types and sizes
ship_types <- list("Carrier" = 5, "Battleship" = 4, "Cruiser" = 3, "Submarine" = 3, "Destroyer" = 2)

# Initialize game board
board <- matrix(0, nrow=BOARD_HEIGHT, ncol=BOARD_WIDTH)

# Place ships on board
place_ships <- function(board) {
  for (type in names(ship_types)) {
    repeat {
      # Choose random starting position for ship
      row <- sample(1:BOARD_HEIGHT, 1)
      col <- sample(1:BOARD_WIDTH, 1)
      direction <- sample(c("horizontal", "vertical"), 1)
      if (direction == "horizontal") {
        cols <- col:(col+ship_types[[type]]-1)
        if (max(cols) > BOARD_WIDTH) next
        if (any(board[row, cols] != 0)) next
        board[row, cols] <- ship_types[[type]]
      } else {
        rows <- row:(row+ship_types[[type]]-1)
        if (max(rows) > BOARD_HEIGHT) next
        if (any(board[rows, col] != 0)) next
        board[rows, col] <- ship_types[[type]]
      }
      break
    }
  }
  board
}

# Display board with hidden ships
display_board <- function(board) {
  for (i in 1:BOARD_HEIGHT) {
    for (j in 1:BOARD_WIDTH) {
      if (board[i, j] == 0) {
        cat("-")
      } else {
        cat(" ")
      }
    }
    cat("\n")
  }
}

# Play game
board <- place_ships(board)
turns <- 0
hits <- 0
while (hits < sum(unlist(ship_types))) {
  turns <- turns + 1
  cat(sprintf("Turn %d\n", turns))
  display_board(board)
  row <- as.integer(readline("Enter row (1-10): "))
  col <- as.integer(readline("Enter col (1-10): "))
  if (board[row, col] == 0) {
    cat("Miss!\n")
  } else {
    cat("Hit!\n")
    board[row, col] <- -1
    hits <- hits + 1
  }
}
cat(sprintf("You won in %d turns!\n", turns))
