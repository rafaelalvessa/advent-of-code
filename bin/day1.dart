import 'dart:io' show FileSystemException;
import 'read_input.dart';

/// Shows the solutions to both puzzles.
void main() {
  try {
    var input = readInput('day1');
    print('Part one: ${partOne(input)}');
    print('Part two: ${partTwo(input) ?? 'Santa never entered the basement.'}');
  } on FileSystemException catch (e) {
    print('Error reading input from file: $e');
  } catch (e) {
    print('Error: $e');
  }
}

/// Returns the number of the floor Santa should go to after following each
/// instruction in [instructions].
///
/// Throws an [Exception] if an invalid instruction is found.
int partOne(String instructions) {
  var floor = 0;

  for (var i = 0; i < instructions.length; i++) {
    switch (instructions[i]) {
      case '(':
        floor++;
        break;
      case ')':
        floor--;
        break;
      default:
        throw 'Invalid instruction at index $i: \'${instructions[i]}\'.';
    }
  }

  return floor;
}

/// Returns the number of the instruction in [instructions] that causes Santa to
/// first enter the basement, or [null] if Santa never enters the basement.
///
/// Throws an [Exception] if an invalid instruction is found.
int partTwo(String instructions) {
  var floor = 0;

  var i = 0;
  while (i < instructions.length && floor != -1) {
    switch (instructions[i]) {
      case '(':
        floor++;
        break;
      case ')':
        floor--;
        break;
      default:
        throw 'Invalid instruction at index $i: \'${instructions[i]}\'.';
    }
    i++;
  }

  return floor == -1 ? i : null;
}
