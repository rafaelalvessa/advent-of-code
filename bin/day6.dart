import 'dart:io' show FileSystemException;
import 'read_input.dart';

/// Shows the solutions to both puzzles.
void main() {
  try {
    var input = readInput('day6');
    var strings = input.split('\n');
    print('Part one: ${partOne(strings)}');
    // print('Part two: ${partTwo(strings)}');
  } on FileSystemException catch (e) {
    print('Error reading input from file: $e');
  } catch (e) {
    print('Error: $e');
  }
}

/// Returns the number of lights that are lit after following all the
/// [instructions].
int partOne(List<String> instructions) {
  var lights = new List<List<bool>>.generate(1000, (_) =>
      new List<bool>.filled(1000, false));
  var task;
  var startX, startY;
  var endX, endY;
  var match;
  var lit = 0;

  RegExp exp = new RegExp(r'(turn \w+|toggle) (\d+),(\d+) through (\d+),(\d+)');

  for (var i = 0; i < instructions.length; i++) {
    if (!exp.hasMatch(instructions[i])) {
      throw 'Invalid instruction at line ${i + 1}: "${instructions[i]}".';
    }

    match = exp.firstMatch(instructions[i]);
    task = match.group(1);
    startX = int.parse(match.group(2));
    startY = int.parse(match.group(3));
    endX = int.parse(match.group(4));
    endY = int.parse(match.group(5));

    for (var x = startX; x <= endX; x++) {
      for (var y = startY; y <= endY; y++) {
        switch (task) {
          case 'turn on':
            if (!lights[x][y]) lit++;
            lights[x][y] = true;
            break;
          case 'turn off':
            if (lights[x][y] && lit > 0) lit--;
            lights[x][y] = false;
            break;
          case 'toggle':
            lit += lights[x][y] ? (lit > 0 ? -1 : 0) : 1;
            lights[x][y] = !lights[x][y];
            break;
        }
      }
    }
  }

  return lit;
}
