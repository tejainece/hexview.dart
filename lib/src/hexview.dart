import 'hex_conv.dart';

class Record {
  final int startAddress;

  /// The data. [null] value means unknown.
  final List<int?> data;

  int get endAddress => startAddress + data.length - 1;

  int get length => data.length;

  Record(this.startAddress, this.data);

  factory Record.prefix(int startAddress, Iterable<int?> data, int size) {
    if (data.length != size) {
      data = <int?>[...List<int?>.filled(size - data.length, null), ...data];

      startAddress -= data.length - size;
    } else {
      data = data.toList();
    }

    return Record(startAddress, data.toList());
  }

  factory Record.suffix(int startAddress, Iterable<int?> data, int size) {
    if (data.length != size) {
      data = <int?>[...data, ...List<int?>.filled(size - data.length, null)];

      startAddress -= data.length - size;
    } else {
      data = data.toList();
    }

    return Record(startAddress, data.toList());
  }

  int? operator [](int address) {
    if (address < startAddress || address > endAddress) {
      throw RangeError.range(address, startAddress, endAddress, 'address');
    }

    return data[address - startAddress];
  }

  operator []=(int address, int value) {
    if (address < startAddress || address > endAddress) {
      throw RangeError.range(address, startAddress, endAddress, 'address');
    }
    data[address - startAddress] = value;
  }

  Record withOffset(int offset) => Record(startAddress + offset, data);

  @override
  String toString() {
    final sb = StringBuffer();
    sb.write('0x' + Hex.hex32(startAddress));
    sb.write('\t');
    for (int? datum in data) {
      if (datum != null) {
        sb.write(Hex.hex8(datum));
      } else {
        sb.write('--');
      }
      sb.write(' ');
    }
    return sb.toString();
  }
}

// Experimental : print ASCII repr
abstract class AbsRecordFormatter {
  int get recordLength;

  String format(Record record, {int? fullDataEndAddress});
}

class DefaultRecordFormatter implements AbsRecordFormatter {
  const DefaultRecordFormatter({this.recordLength = 16});

  @override
  final int recordLength;

  String format(Record record, {int? fullDataEndAddress}) {
    if (record.length != recordLength) {
      throw Exception('Record should be of length $recordLength');
    }

    final sb = StringBuffer();
    sb.write('0x' + Hex.hex32(record.startAddress));
    sb.write('\t');
    for (int? datum in record.data) {
      if (datum != null) {
        sb.write(Hex.hex8(datum));
      } else {
        sb.write('--');
      }
      sb.write(' ');
    }
    return sb.toString();
  }
}

// Experimental : print ASCII repr
class AsciiRecordFormatter implements AbsRecordFormatter {
  const AsciiRecordFormatter({this.recordLength = 16});

  @override
  final int recordLength;

  String format(Record record, {int fullDataEndAddress}) {
    if (record.length != recordLength) {
      throw Exception('Record should be of length $recordLength');
    }

    final sb = StringBuffer();
    sb.write('\t\t');
    for (int datum in record.data) {
      if (datum == null) {
        sb.write(' ');
      } else if (datum > 32 && datum < 127) {
        sb.write(String.fromCharCode(datum));
      } else {
        sb.write('.');
      }
      sb.write(' ');
    }
    return sb.toString();
  }
}

String hexView(int startAddress, Iterable<int> data,
    {AbsRecordFormatter formatter = const DefaultRecordFormatter(),
    bool printAscii = false,
    AbsRecordFormatter asciiFormatter = const AsciiRecordFormatter(),
    String recordSeparator = '\n'}) {
  final recordLength = formatter.recordLength;
  final sb = StringBuffer();

  int address;

  {
    final firstTake = recordLength - (startAddress % recordLength);
    final first = data.take(firstTake);
    data = data.skip(firstTake);
    final record = Record.prefix(startAddress, first, recordLength);
    sb.write(formatter.format(record));
    // Experimental : print ASCII repr
    if (printAscii) {
      sb.write(asciiFormatter.format(record));
    }
    address = record.startAddress + recordLength;
  }

  while (data.length >= recordLength) {
    final recordData = data.take(recordLength);
    final record = Record(address, recordData.toList());
    sb.write(recordSeparator);
    sb.write(formatter.format(record));
    // Experimental : print ASCII repr
    if (printAscii) {
      sb.write(asciiFormatter.format(record));
    }
    address = record.startAddress + recordLength;
    data = data.skip(recordLength);
  }

  if (data.isNotEmpty) {
    final record = Record.suffix(address, data, recordLength);
    sb.write(recordSeparator);
    sb.write(formatter.format(record));
    // Experimental : print ASCII repr
    if (printAscii) {
      sb.write(asciiFormatter.format(record));
    }
  }

  return sb.toString();
}
