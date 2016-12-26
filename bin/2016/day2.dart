import 'package:advent_of_code/input_reader.dart';

/// A keypad has a layout of buttons to insert the bathroom code.
class Keypad {
  final List<String> buttons;
  int row;
  int column;

  Keypad(this.buttons, this.row, this.column);

  /// Returns the key of the current button.
  String get currentButton => buttons[row][column];

  /// Moves in the specified [direction].
  ///
  /// Throws an [Exception] if the [direction] is invalid.
  void move(direction) {
    switch (direction) {
      case 'U':
        if (row > 0 && buttons[row - 1][column] != null) row--;
        break;
      case 'R':
        if (column < buttons[row].length - 1 &&
            buttons[row][column + 1] != null) {
          column++;
        }
        break;
      case 'D':
        if (row < buttons.length - 1 && buttons[row + 1][column] != null) row++;
        break;
      case 'L':
        if (column > 0 && buttons[row][column - 1] != null) column--;
        break;
      default:
        throw 'Invalid instruction: $direction.';
    }
  }
}

/// Shows the solutions to both puzzles.
void main() {
  try {
    var input = readInput('2016/day2').split('\n');
    print('Puzzle one: ${puzzleOne(input)}');
    print('Puzzle two: ${puzzleTwo(input)}');
  } catch (e) {
    print('Error: $e');
  }
}

/// Returns the solution to the first puzzle given a valid [input].
///
/// It follows all the instructions and returns the bathroom code.
///
/// Throws an [Exception] if an instruction is invalid.
String puzzleOne(List<String> input) {
  var buttons = [
    ['1', '2', '3'],
    ['4', '5', '6'],
    ['7', '8', '9']
  ];
  return _findCode(input, new Keypad(buttons, 1, 1));
}

/// Returns the solution to the second puzzle given a valid [input].
///
/// It follows all the instructions and returns the bathroom code.
///
/// Throws an [Exception] if an instruction is invalid.
String puzzleTwo(List<String> input) {
  var buttons = [
    [null, null, '1', null, null],
    [null, '2', '3', '4', null],
    ['5', '6', '7', '8', '9'],
    [null, 'A', 'B', 'C', null],
    [null, null, 'D', null, null]
  ];
  return _findCode(input, new Keypad(buttons, 2, 0));
}

/// Returns the bathroom code given a valid [input] and a [keypad] with a button
/// layout.
///
/// Throws an [Exception] if an instruction is invalid.
String _findCode(List<String> input, Keypad keypad) {
  var code = new StringBuffer();

  for (var instructions in input) {
    for (var i = 0; i < instructions.length; i++) {
      keypad.move(instructions[i]);
    }
    code.write(keypad.currentButton);
  }

  return code.toString();
}
