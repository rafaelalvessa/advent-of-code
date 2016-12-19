import 'dart:io';

/// Returns a [String] with the contents of the file named [filename].
///
/// Throws a [FileSystemException] if there is an error reading the input file.
String readInput(String filename) {
  var inputFile = new File('input/${filename}');
  if (!inputFile.existsSync()) {
    throw new FileSystemException('Input file "$filename" does not exist.');
  }
  return inputFile.readAsStringSync().trim();
}
