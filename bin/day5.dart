import 'dart:io' show FileSystemException;
import 'read_input.dart';

/// Shows the solutions to both puzzles.
void main() {
  try {
    var input = readInput('day5');
    var strings = input.split('\n');
    print('Part one: ${partOne(strings)}');
  } on FileSystemException catch (e) {
    print('Error reading input from file: $e');
  } catch (e) {
    print('Error: $e');
  }
}

/// Returns the number of nice strings in [strings].
int partOne(List<String> strings) {
  var niceStrings = 0;
  for (var i = 0; i < strings.length; i++) {
    if (_isNice(strings[i])) niceStrings++;
  }
  return niceStrings;
}

/// Returns `true` if [string] is a nice string.
bool _isNice(String string) =>
    _hasThreeVowels(string) && _hasLetterTwice(string) &&
    !_hasForbiddenString(string);

/// Returns `true` if [string] contains at least three vowels.
bool _hasThreeVowels(String string) =>
    new RegExp(r'[aeiou]').allMatches(string).length >= 3;

/// Returns `true` if [string] contains one letter that appears at least twice.
bool _hasLetterTwice(String string) => string.contains(new RegExp(r'(.)\1'));

/// Returns `true` if [string] contains a forbidden string: "ab", "cd", "pq" or
/// "xy".
bool _hasForbiddenString(String string) =>
    string.contains(new RegExp(r'ab|cd|pq|xy'));
