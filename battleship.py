from random import randint

board = []

# Create the board
for x in range(5):
    board.append(["O"] * 5)

# Function to print the board


def print_board(board):
    for row in board:
        print(" ".join(row))


# Start the game
print("Let's play Battleship!")
print("Coded By R3DHULK!!!")
print_board(board)

# Place the ship randomly on the board
ship_row = randint(0, len(board) - 1)
ship_col = randint(0, len(board[0]) - 1)

# Game loop
for turn in range(4):
    print(f"Turn {turn + 1}")

    # Get the user's guess
    guess_row = int(input("Guess Row (0-4): "))
    guess_col = int(input("Guess Col (0-4): "))

    # Check if the guess is correct
    if guess_row == ship_row and guess_col == ship_col:
        print("Congratulations! You sank my battleship!")
        break
    else:
        if guess_row not in range(5) or \
           guess_col not in range(5):
            print("Oops, that's not even in the ocean.")
        elif board[guess_row][guess_col] == "X":
            print("You guessed that one already.")
        else:
            print("You missed my battleship!")
            board[guess_row][guess_col] = "X"
        print_board(board)
    if turn == 3:
        print("Game Over")
