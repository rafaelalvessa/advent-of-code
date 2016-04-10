import 'dart:io';

/// Returns a [String] with the contents of the file named [filename].
///
/// An error message is shown instead if the operation fails.
String readInput(String filename) {
  try {
    return new File(filename).readAsStringSync().trim();
  } on FileSystemException catch (e) {
    print('Error reading input from file: $e');
  }
}
