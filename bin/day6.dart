import 'dart:io' show FileSystemException;
import 'read_input.dart';

/// Shows the solutions to both puzzles.
void main() {
  try {
    var input = readInput('day6');
    var strings = input.split('\n');
    print('Part one: ${partOne(strings)}');
    print('Part two: ${partTwo(strings)}');
  } on FileSystemException catch (e) {
    print('Error reading input from file: $e');
  } catch (e) {
    print('Error: $e');
  }
}

/// Returns the number of lights that are lit after following all the
/// [instructions].
///
/// Throws an [Exception] if any of the instructions is invalid.
int partOne(List<String> instructions) {
  var lights = new List<List<bool>>.generate(1000, (_) =>
      new List<bool>.filled(1000, false));

  return _followInstructions(instructions, lights, _doTaskOne);
}

/// Returns the total brightness of all lights after following all the
/// [instructions].
///
/// Throws an [Exception] if any of the instructions is invalid.
int partTwo(List<String> instructions) {
  var lights = new List<List<int>>.generate(1000, (_) =>
      new List<int>.filled(1000, 0));
  return _followInstructions(instructions, lights, _doTaskTwo);
}

/// Abstract function to return the result after following the [instructions]
/// to change the [lights] by calling [doTask].
///
/// Throws an [Exception] if any of the instructions is invalid.
int _followInstructions(List<String> instructions, List<List> lights,
    Function doTask) {
  var task;
  var startX, startY;
  var endX, endY;
  var match;
  var result = 0;
  var change;

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
        change = doTask(task, lights, x, y);
        result += result == 0 && change < 0 ? 0 : change;
      }
    }
  }

  return result;
}

/// Returns the result of executing the [task] to change the light in [lights]
/// at row [x] and column [y].
int _doTaskOne(String task, List<List<bool>> lights, int x, int y) {
  var result = 0;

  switch (task) {
    case 'turn on':
      if (!lights[x][y]) result++;
      lights[x][y] = true;
      break;
    case 'turn off':
      if (lights[x][y]) result--;
      lights[x][y] = false;
      break;
    case 'toggle':
      result += lights[x][y] ? -1 : 1;
      lights[x][y] = !lights[x][y];
      break;
  }

  return result;
}

/// Returns the result of executing the [task] to change the light in [lights]
/// at row [x] and column [y].
int _doTaskTwo(String task, List<List<int>> lights, int x, int y) {
  switch (task) {
    case 'turn on':
      lights[x][y]++;
      return 1;
    case 'turn off':
      if (lights[x][y] > 0) {
        lights[x][y]--;
        return -1;
      }
      break;
    case 'toggle':
      lights[x][y] += 2;
      return 2;
  }

  return 0;
}
