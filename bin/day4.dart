import 'dart:convert';
import 'dart:math';
import 'package:crypto/crypto.dart';

void main() {
  var secretKey = 'ckczppom';
  print('Part one: ${partOne(secretKey) ?? 'No MD5 hash found.'}');
}

int partOne(String secretKey) {
  var hash;
  print('Calculating...');
  for (var i = 0; i < pow(10, secretKey.length) - 1; i++) {
    hash = md5.convert(UTF8.encode('${secretKey}${i}'));
    if (hash.toString().startsWith(new RegExp(r'0{5,}'))) {
      print('MD5 hash: ${hash}');
      return i;
    }
  }
  return null;
}
