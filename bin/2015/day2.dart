import 'dart:math' show min;
import 'package:advent_of_code/input_reader.dart';

/// Shows the solutions to both puzzles.
void main() {
  try {
    var input = readInput('2015/day2').split('\n');
    print('Part one: ${partOne(input)}');
    print('Part two: ${partTwo(input)}');
  } catch (e) {
    print('Error: $e');
  }
}

/// Returns the total square feet of wrapping paper the elves should order for
/// the list of present dimensions in [presents].
///
/// Throws an [Exception] if the present has invalid dimensions.
/// Throws a [FormatException] if an error occurs parsing any of the present's
/// dimensions to an [int].
int partOne(List<String> presents) {
  var total = 0;
  var surfaces;
  for (var present in presents) {
    surfaces = getSurfaceAreas(getDimensions(present));
    total += 2 * surfaces.reduce((x, y) => x + y) + getSlack(surfaces);
  }
  return total;
}

/// Returns the total feet of ribbon the elves should order for the list of
/// present dimensions in [presents].
///
/// Throws an [Exception] if the present has invalid dimensions.
/// Throws a [FormatException] if an error occurs parsing any of the present's
/// dimensions to an [int].
int partTwo(List<String> presents) {
  var total = 0;
  var dimensions;
  for (var present in presents) {
    dimensions = getDimensions(present);
    total += getSmallestPerimeter(dimensions) +
        dimensions[0] * dimensions[1] * dimensions[2];
  }
  return total;
}

/// Returns a list with the dimensions of the [present].
///
/// Throws an [Exception] if the present has invalid dimensions.
/// Throws a [FormatException] if an error occurs parsing any of the present's
/// dimensions to an [int].
List<int> getDimensions(String present) {
  var dimensions = present.split('x');
  if (dimensions.length != 3) throw 'Invalid present dimensions: $present.';
  return [
    int.parse(dimensions[0]),
    int.parse(dimensions[1]),
    int.parse(dimensions[2])
  ];
}

/// Returns a list with the three surface areas of a present based on its
/// [dimensions].
List<int> getSurfaceAreas(List<int> dimensions) => [
  dimensions[0] * dimensions[1],
  dimensions[1] * dimensions[2],
  dimensions[0] * dimensions[2]
];

/// Returns the smallest perimenter of any one side of the present based on its
/// [dimensions].
int getSmallestPerimeter(List<int> dimensions) {
  dimensions.sort();
  return 2 * (dimensions[0] + dimensions[1]);
}

/// Returns the slack, which is the same size as the present's smallest surface
/// area in [surfaces].
int getSlack(List<int> surfaces) =>
    min(min(surfaces[0], surfaces[1]), surfaces[2]);
