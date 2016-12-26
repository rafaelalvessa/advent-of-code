import 'package:advent_of_code/input_reader.dart';

const north = 'N';
const east = 'E';
const south = 'S';
const west = 'W';
const right = 'R';
const left = 'L';

/// A location is a set of coordinates (x, y) that change by walking in a
/// certain direction: north, east, south or west.
class Location {
  int x;
  int y;
  String direction;

  /// A location, by location, starts at (0, 0) facing north.
  Location([this.x = 0, this.y = 0]) {
    direction = north;
  }

  /// Returns the absolute distance to the initial location (0, 0).
  int get distance => x.abs() + y.abs();

  /// Takes a left or right [turn] and walks a certain amount of [steps].
  void walk(String turn, int steps) {
    _move(turn, steps);
    _updateDirection(turn);
  }

  /// Takes a left or right [turn] and walks a certain amount of [steps] until
  /// it walks to a location in [visited] that has already been visited once
  /// before.
  bool walkUntilVisitedTwice(String turn, int steps, Set<String> visited) {
    var visitedTwice = false;

    while (steps > 0 && !visitedTwice) {
      _move(turn);
      visitedTwice = !visited.add(this.toString());
      steps--;
    }

    _updateDirection(turn);
    return visitedTwice;
  }

  /// Changes the direction depending on the [turn].
  ///
  /// For example, turning right while facing north changes the direction to
  /// east.
  void _updateDirection(String turn) {
    switch (direction) {
      case north:
        direction = turn == right ? east : west;
        break;
      case east:
        direction = turn == right ? south : north;
        break;
      case south:
        direction = turn == right ? west : east;
        break;
      case west:
        direction = turn == right ? north : south;
        break;
    }
  }

  /// Follows a left or right [turn] and takes a certain amount of [steps].
  ///
  /// If the number of [steps] is not specified, a single step is taken by
  /// default.
  void _move(String turn, [int steps = 1]) {
    switch (direction) {
      case north:
        x += turn == right ? steps : -steps;
        break;
      case east:
        y += turn == right ? -steps : steps;
        break;
      case south:
        x += turn == right ? -steps : steps;
        break;
      case west:
        y += turn == right ? steps : -steps;
        break;
    }
  }

  /// Returns a string with the coordinates of this location in the format
  /// (x, y).
  String toString() => '($x, $y)';
}

/// Shows the solutions to both puzzles.
void main() {
  try {
    var input = readInput('2016/day1');
    print('Puzzle one: ${puzzleOne(input)}');

    var result = puzzleTwo(input);
    if (result == -1) {
      print('Puzzle two: No location was visited twice.');
    } else {
      print('Puzzle two: $result');
    }
  } catch (e) {
    print('Error: $e');
  }
}

/// Returns the solution to the first puzzle given a valid [input].
///
/// It follows all the instructions and returns the shortest path to the
/// destination.
///
/// Throws an [Exception] if an instruction is invalid.
int puzzleOne(String input) {
  var location = new Location();
  var regexp = new RegExp(r'^(R|L)(\d+)$');
  var match;

  for (var instruction in input.split(', ')) {
    if (!regexp.hasMatch(instruction)) {
      throw 'Invalid instruction: $instruction';
    }

    match = regexp.firstMatch(instruction);
    location.walk(match.group(1), int.parse(match.group(2)));
  }

  return location.distance;
}

/// Returns the solution to the first puzzle given a valid [input].
///
/// It follows all the instructions until a location has been visited twice,
/// and returns how many blocks away that location is. If no location is visited
/// twice, returns -1.
///
/// Throws an [Exception] if an instruction is invalid.
int puzzleTwo(String input) {
  var location = new Location();
  var visited = new Set<String>.from([location.toString()]);
  var instructions = input.split(', ');
  var regexp = new RegExp(r'^(R|L)(\d+)$');
  var match;
  var visitedTwice = false;
  var i = 0;
  var turn;
  var steps;

  while (i < instructions.length && !visitedTwice) {
    if (!regexp.hasMatch(instructions[i])) {
      throw 'Invalid instruction: ${instructions[i]}';
    }

    match = regexp.firstMatch(instructions[i]);
    turn = match.group(1);
    steps = int.parse(match.group(2));

    visitedTwice = location.walkUntilVisitedTwice(turn, steps, visited);
    i++;
  }

  return visitedTwice ? location.distance : -1;
}
