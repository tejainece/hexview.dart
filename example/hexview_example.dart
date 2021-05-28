import 'package:ninja_hex/ninja_hex.dart';

void main() {
  print(hexView(5, List<int>.generate(125, (i) => i + 5), printAscii: true));
}
