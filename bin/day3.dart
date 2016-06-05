import 'dart:io' show FileSystemException;
import 'read_input.dart';

/// Shows the solutions to both puzzles.
void main() {
  try {
    var input = readInput('day3');
    print('Part one: ${partOne(input)}');
    // print('Part two: ${partTwo(input)}');
  } on FileSystemException catch (e) {
    print('Error reading input from file: $e');
  } catch (e) {
    print('Error: $e');
  }
}

/// Returns the number of houses that receive at least one present after
/// following all the [directions].
///
/// Throws an [Exception] if an invalid direction is given.
int partOne(String directions) {
  var houses = 1;
  var visited = new Set();
  var x = 0;
  var y = 0;
  visited.add('${x}, ${y}');

  for (var i = 0; i < directions.length; i++) {
    switch (directions[i]) {
      case '^':
        y++;
        break;
      case '>':
        x++;
        break;
      case 'v':
        y--;
        break;
      case '<':
        x--;
        break;
      default:
        throw 'Invalid direction at index $i: "${directions[i]}".';
    }

    if (visited.add('${x}, ${y}')) houses++;
  }

  return houses;
}
