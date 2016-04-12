import 'dart:math' show min;
import 'read_input.dart';

/// Shows the solution for part one and two of the problem.
void main() {
  var input = readInput('day2_input').split('\n');
  try {
    print('Part one: ${partOne(input)}');
  } catch (e) {
    print('Error: $e');
  }
}

/// Returns the total square feet of wrapping paper the elves should order for
/// the list of present dimensions in [presents].
int partOne(List<String> presents) {
  var total = 0;
  var dimensions;
  var surfaces;
  for (var present in presents) {
    dimensions = present.split('x');
    if (dimensions.length != 3) throw 'Invalid present dimensions: ${present}.';
    surfaces = getSurfaceAreas(dimensions);
    total += 2 * surfaces.reduce((x, y) => x + y) + getSlack(surfaces);
  }
  return total;
}

/// Returns a list with the three surface areas of a present based on its
/// [dimensions].
///
/// Throws a [FormatException] if an error occurs parsing any of the present's
/// dimensions to an [int].
List<int> getSurfaceAreas(List<String> dimensions) => [
  int.parse(dimensions[0]) * int.parse(dimensions[1]),
  int.parse(dimensions[1]) * int.parse(dimensions[2]),
  int.parse(dimensions[0]) * int.parse(dimensions[2])
];

/// Returns the slack, which is the same size as the present's smallest surface
/// area in [surfaces].
int getSlack(List<int> surfaces) =>
    min(min(surfaces[0], surfaces[1]), surfaces[2]);
