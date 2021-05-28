# ninja_hex

Dart library to encode, decode and pretty print hex string

# Usage

## Hex codec

```dart
void main() {
  final random = Random();
  final data = List<int>.generate(20, (index) => random.nextInt(256));
  print(data);
  final encoded = hexEncode(data);
  print(encoded);
  final decoded = hexDecode(encoded);
  print(decoded);
}
```

## Hex view

```dart
void main() {
	print(hexView(5, List<int>.generate(125, (i) => i + 5), printAscii: true));
}
```

## BigInt from hex

```dart
import 'package:hexview/ninja_hex.dart';

void main() {
  final hexString = '00:B2:0C:EC:EA:F3:76:B2:F7:87:56:B6:97:57:4C:DD:A1:5C:A1:59:41:D6:35:0D:31:9E:11:D3:3E:18:ED:E6:08:07:99:2B:EB:53:1B:D4:A5:77:CA:58:23:FD:81:9A:39:F5:0E:DD:C7:4C:9D:8E:A0:6C:76:8A:17:0A:89:95:3F:89:06:0E:3B:A5:BC:E1:D6:82:F7:15:9B:04:EC:2F:46:C0:32:A9:AC:0B:2C:89:28:CE:89:5A:A8:BC:13:E0:8F:4C:EA:4C:05:67:5A:A5:4C:6F:C1:A4:A6:A2:9F:20:7A:24:ED:9D:7D:1A:57:8C:C6:5F:0B:33:DA:6C:1D:A2:06:E8:BA:74:23:30:1F:C4:C3:BB:EF:F1:7B:6A:C1:74:A9:9D:1E:E4:33:91:CF:7C:CE:F0:6F:D1:7C:32:39:51:BA:76:BA:36:DD:95:EE:2D:28:52:BF:84:12:DE:9F:21:81:15:64:58:87:4D:25:33:0C:B6:B3:D9:E0:A5:25:E0:8D:76:FC:AA:69:E1:82:0A:AB:3E:2E:E9:CC:AB:79:19:8C:EF:5A:86:D4:B6:FB:5A:99:C5:F0:73:69:CF:F4:29:74:58:9C:B6:B4:90:64:07:65:BC:34:79:C8:1D:64:2F:58:A6:AA:8C:79:37:92:9C:93:CF:5F:8F:D3:42:DE:78:A9:52:D0:5C:CD:FE:87:CC:6F:C2:DD:E5:22:D7:09:3D:94:74:BF:ED:32:41:EE:50:13:03:CB:E1:CE:54:17:CD:63:7C:6A:D8:7C:4C:E6:1A:D8:7A:29:12:26:44:C7:45:2C:5F:7E:17:BA:33:02:01:AA:08:B4:2D:DD:E5:76:60:C5:C8:05:87:D9:4B:D2:FF:94:EF:D0:DE:6E:0C:18:04:59:5D:41:37:8E:59:1C:7C:59:5C:6E:70:34:BB:03:01:4A:37:4D:52:CC:38:CC:78:D5:C2:4E:9A:1B:90:B0:60:56:15:1C:6F:67:E6:FE:2A:0B:12:95:10:D4:62:9F:38:06:46:7C:24:37:20:03:79:CB:DB:71:0D:F4:FD:43:AE:85:4E:58:06:77:C5:49:8A:EB:86:AF:DF:C8:26:E9:9D:EB:B1:93:61:28:B8:BD:E9:93:F1:80:EE:61:B3:AA:18:CF:63:36:9A:34:65:59:F2:7F:98:CA:CD:24:C6:E3:FD:5C:33:94:10:39:23:5E:96:BF:4B:37:99:12:4F:45:5C:C9:4B:73:B5:B2:76:3F:FB:11:2E:2B:E9:26:02:B3:82:8C:AF:EA:7B:0A:31:60:FD:AE:C8:75:EA:4B:43:7B:71:AD:97:9C:AC:1C:68:1B:99:81:0D:88:02:24:27:CB:06:ED';
  print(bigIntFromHex(hexString));
}
```
