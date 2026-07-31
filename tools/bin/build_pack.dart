// Builds a ThimbleweedPark.ggpackN overlay file from a folder of loose
// patch files (fonts, images, text). The game engine natively supports
// stacking additional numbered ggpack files (ggpack3, ggpack4, ...)
// alongside ggpack1/ggpack2 without touching them - the same mechanism
// the official "Ransome Uncensored" DLC uses via ggpack3.
//
// Usage: dart run bin/build_pack.dart <patch_dir> <output.ggpack4>
import 'dart:io';
import 'package:ngpack/ngpack.dart';

void main(List<String> arguments) {
  if (arguments.length != 2) {
    print('Usage: dart run bin/build_pack.dart <patch_dir> <output.ggpack4>');
    exit(1);
  }
  final patchDir = arguments[0];
  final outputPath = arguments[1];

  final builder = GGPackBuilder(knownXorKeys.fromId(KnownXorKeyId.Key56ad));
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
