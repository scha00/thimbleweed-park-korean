// Builds a Delores.ggpackN overlay file from a folder of loose patch files,
// using the same overlay mechanism as build_pack.dart but with the
// "Delores" xor key used by the Delores standalone game instead of the
// main Thimbleweed Park key.
//
// Usage: dart run bin/build_delores_pack.dart <patch_dir> <output.ggpack4>
import 'dart:io';
import 'package:ngpack/ngpack.dart';

void main(List<String> arguments) {
  if (arguments.length != 2) {
    print('Usage: dart run bin/build_delores_pack.dart <patch_dir> <output.ggpack4>');
    exit(1);
  }
  final patchDir = arguments[0];
  final outputPath = arguments[1];

  final builder = GGPackBuilder(knownXorKeys.fromId(KnownXorKeyId.Delores));
  var count = 0;
  for (var entity in Directory(patchDir).listSync()) {
    if (entity is File) {
      final name = entity.uri.pathSegments.last;
      builder.addFile(name, entity.path);
      count++;
    }
  }
  File(outputPath).writeAsBytesSync(builder.build(), flush: true);
  print('Overlay pack created with $count entries at $outputPath');
}
