import 'package:advent_of_code/input_reader.dart';


/// A triangle has a side a, b and c.
class Triangle {
  final int a, b, c;

  /// Creates a Triangle instance with sides [a], [b] and [c].
  Triangle(this.a, this.b, this.c);

  /// Creates a Triangle instance from a list of [sides].
  Triangle.fromList(List<int> sides)
      : a = sides[0],
        b = sides[1],
        c = sides[2];

  /// Returns true if this triangle is possible.
  ///
  /// A triangle is possible if the sum of any two sides is greater than the
  /// remaining side.
  bool isPossible() => a + b > c && a + c > b && b + c > a;
}

/// Shows the solutions to both puzzles.
void main() {
  try {
    var input = readInput('2016/day3').split('\n');
    print('Puzzle one: ${puzzleOne(input)}');
    print('Puzzle two: ${puzzleTwo(input)}');
  } catch (e) {
    print('Error: $e');
  }
}

/// Returns the number of possible triangles given a valid [input].
///
/// Throws an [Exception] if any triangle sides are invalid.
int puzzleOne(List<String> input) {
  var sides;
  var triangle;
  var possible = 0;

  for (var line in input) {
    sides = line.replaceAll(new RegExp(r'\s{2,}'), ' ').trim().split(' ');
    triangle = new Triangle.fromList(_getParsedSides(sides));
    possible += triangle.isPossible() ? 1 : 0;
  }

  return possible;
}

/// Returns the number of possible triangles given a valid [input] of triangle
/// sides grouped vertically.
///
/// Throws an [Exception] if any triangle sides are invalid.
int puzzleTwo(List<String> input) {
  if (input.length % 3 != 0) {
    throw 'Input does not contain three sides for each triangle.';
  }

  var line;
  var sides = new List<List<int>>();
  var triangles = new List<Triangle>();
  var possible = 0;

  for (var i = 0; i < input.length; i++) {
    line = input[i].replaceAll(new RegExp(r'\s{2,}'), ' ').trim().split(' ');
    sides.add(_getParsedSides(line));

    if ((i + 1) % 3 == 0) {
      for (var j = 0; j < 3; j++) {
        triangles.add(new Triangle(sides[i - 2][j], sides[i - 1][j],
            sides[i][j]));
      }
    }
  }

  triangles.forEach((triangle) => possible += triangle.isPossible() ? 1 : 0);
  return possible;
}

/// Returns a list with the parsed triangle [sides].
///
/// Throws an [Exception] if any of the sides is not an integer.
List<int> _getParsedSides(List<String> sides) {
  var parsedSides = new List<int>();
  for (var side in sides) {
    parsedSides.add(int.parse(side, onError: (source) => null));
  }
  if (parsedSides.contains(null)) throw 'Invalid triangle sides: "$sides".';
  return parsedSides;
}
