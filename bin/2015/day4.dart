import 'dart:convert';
import 'dart:math';
import 'package:crypto/crypto.dart';

/// Shows the solutions to both puzzles.
void main() {
  var secretKey = 'ckczppom';
  print('Part one: ${partOne(secretKey) ?? 'No MD5 hash found.'}');
  print('Part two: ${partTwo(secretKey) ?? 'No MD5 hash found.'}');
}

/// Returns the answer to part one given a [secretKey], or [null] if no hash can
/// be produced.
int partOne(String secretKey) => getHash(secretKey, 5);

/// Returns the answer to part one given a [secretKey], or [null] if no hash can
/// be produced.
int partTwo(String secretKey) => getHash(secretKey, 6);

/// Returns the lowest positive number that, together with the [secretKey],
/// produces an MD5 hash which, in hexadecimal, starts with a sequence of zeros
/// whose length is greater than or equal to [zeros]. If such a hash cannot be
/// produced, returns [null] instead.
int getHash(String secretKey, int zeros) {
  var hash;
  print('Calculating...');
  for (var i = 0; i < pow(10, secretKey.length) - 1; i++) {
    hash = md5.convert(UTF8.encode('$secretKey$i'));
    if (hash.toString().startsWith(new RegExp('0{$zeros,}'))) {
      print('MD5 hash: $hash');
      return i;
    }
  }
  return null;
}
