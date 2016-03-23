import 'dart:io' show File;

/// Shows the solution for part one and two of the problem.
void main() {
  var input;
  try {
    input = new File('input').readAsStringSync();
    print('Part one: ${partOne(input)}');
    var basement = partTwo(input);
    print('Part two: ${basement ?? 'Santa never entered the basement.'}');
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
  for (var i = 0; i < instructions.length - 1; i++) {
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
  for (var i = 0; i < instructions.length - 1; i++) {
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
    if (floor == -1) return i + 1;
  }
  return null;
}
