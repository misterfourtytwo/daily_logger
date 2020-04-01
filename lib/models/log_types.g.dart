// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'log_types.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LogTypesAdapter extends TypeAdapter<LogTypes> {
  @override
  final typeId = 1;

  @override
  LogTypes read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return LogTypes.note;
      case 1:
        return LogTypes.payment;
      case 2:
        return LogTypes.task;
      case 3:
        return LogTypes.continuous;
      default:
        return null;
    }
  }

  @override
  void write(BinaryWriter writer, LogTypes obj) {
    switch (obj) {
      case LogTypes.note:
        writer.writeByte(0);
        break;
      case LogTypes.payment:
        writer.writeByte(1);
        break;
      case LogTypes.task:
        writer.writeByte(2);
        break;
      case LogTypes.continuous:
        writer.writeByte(3);
        break;
    }
  }
}
