// Extracts a single raw (non-lossy) file from a ggpack archive.
// Usage: dart run bin/extract_raw.dart <pack.ggpack1> <name-in-pack> <out-path>
import 'dart:io';
import 'package:ngpack/ngpack.dart';

void main(List<String> arguments) {
  final packPath = arguments[0];
  final name = arguments[1];
  final outPath = arguments[2];
  final pack = GGPackDecoder.fromFile(packPath);
  final raw = pack.extract(name, false);
  File(outPath).writeAsBytesSync(raw);
  print('wrote ${raw.length} raw bytes to $outPath');
}
