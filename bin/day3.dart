import 'dart:io' show FileSystemException;
import 'read_input.dart';

/// Shows the solutions to both puzzles.
void main() {
  try {
    var input = readInput('day3');
    print('Part one: ${partOne(input)}');
    print('Part two: ${partTwo(input)}');
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
  var visited = new Set<String>();
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

/// Returns the number of houses that receive at least one present after
/// Santa and Robo-Santa follow all the [directions].
///
/// Throws an [Exception] if an invalid direction is given.
int partTwo(String directions) {
  var houses = 1;
  var visited = new Set<String>();
  var santa = new Location(0, 0);
  var roboSanta = new Location(0, 0);
  visited.add(santa.toString());

  for (var i = 0; i < directions.length; i++) {
    if (i.isEven) {
      _move(santa, i, directions[i]);
      houses += visited.add(santa.toString()) ? 1 : 0;
    } else {
      _move(roboSanta, i, directions[i]);
      houses += visited.add(roboSanta.toString()) ? 1 : 0;
    }
  }

  return houses;
}

/// Changes the [location] after moving in the [direction] at index [i].
///
/// Throws an [Exception] if an invalid direction is given.
void _move(Location location, int i, String direction) {
  switch (direction) {
    case '^':
      location.y++;
      break;
    case '>':
      location.x++;
      break;
    case 'v':
      location.y--;
      break;
    case '<':
      location.x--;
      break;
    default:
      throw 'Invalid direction at index $i: "${direction}".';
  }
}

/// A two-dimension location.
class Location {
  int x;
  int y;

  Location(this.x, this.y);

  /// Returns a string representation of this location.
  String toString() => '(${x}, ${y})';
}
