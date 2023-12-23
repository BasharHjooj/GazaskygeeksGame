import 'dart:io';

class TicTacToeBoard {
  late List<String> cells;

  TicTacToeBoard() {
    cells = List.generate(9, (index) => (index + 1).toString());
  }

  void printBoard() {
    for (int i = 0; i < 9; i += 3) {
      print('${cells[i]} | ${cells[i + 1]} | ${cells[i + 2]}');
      if (i < 6) print('---------');
    }
  }

  bool isCellOccupied(int position) {
    return cells[position - 1] == 'X' || cells[position - 1] == 'O';
  }

  void occupyCell(int position, String player) {
    cells[position - 1] = player;
  }

  bool checkWin(String player) {
    for (int i = 0; i < 3; i++) {
      if (cells[i] == player && cells[i + 3] == player && cells[i + 6] == player) {
        return true; // Check columns
      }
      if (cells[i * 3] == player && cells[i * 3 + 1] == player && cells[i * 3 + 2] == player) {
        return true; // Check rows
      }
    }

    if (cells[0] == player && cells[4] == player && cells[8] == player) {
      return true; // Check diagonal (top-left to bottom-right)
    }
    if (cells[2] == player && cells[4] == player && cells[6] == player) {
      return true; // Check diagonal (top-right to bottom-left)
    }

    return false;
  }

  bool isBoardFull() {
    return !cells.contains('1') &&
        !cells.contains('2') &&
        !cells.contains('3') &&
        !cells.contains('4') &&
        !cells.contains('5') &&
        !cells.contains('6') &&
        !cells.contains('7') &&
        !cells.contains('8') &&
        !cells.contains('9');
  }
}

class TicTacToeGame {
  late TicTacToeBoard board;
  late String currentPlayer;

  TicTacToeGame() {
    board = TicTacToeBoard();
    currentPlayer = 'X';
  }

  void switchPlayer() {
    currentPlayer = (currentPlayer == 'X') ? 'O' : 'X';
  }

  void play() {
    int? move;
    bool validMove;

    do {
      board.printBoard();
      print('$currentPlayer, enter your move (1-9):');
      move = int.tryParse(stdin.readLineSync() ?? '');

      validMove = !board.isCellOccupied(move ?? 0);

      if (!validMove) {
        print('Invalid input. Please choose an unoccupied cell.');
      }

    } while (!validMove);

    board.occupyCell(move ?? 0, currentPlayer);

    if (board.checkWin(currentPlayer)) {
      board.printBoard();
      print('$currentPlayer wins!');
    } else if (board.isBoardFull()) {
      board.printBoard();
      print('It\'s a tie!');
    } else {
      switchPlayer();
      play();
    }
  }
}

void main() {
  do {
    TicTacToeGame game = TicTacToeGame();
    game.play();

    print('Play again? (yes/no):');
  } while (stdin.readLineSync()?.toLowerCase() == 'yes');
}
