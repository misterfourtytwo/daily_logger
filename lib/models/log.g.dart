// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'log.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LogAdapter extends TypeAdapter<Log> {
  @override
  final typeId = 0;

  @override
  Log read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Log()
      ..id = fields[0] as int
      ..type = fields[1] as LogTypes
      ..title = fields[2] as String
      ..content = fields[3] as String
      ..created = fields[4] as DateTime
      ..lastUpdate = fields[5] as DateTime
      ..tags = (fields[6] as List)?.cast<String>()
      ..started = fields[8] as DateTime
      ..finished = fields[9] as DateTime
      ..deadline = fields[11] as DateTime
      ..completed = fields[12] as bool
      ..price = fields[14] as Payment
      ..alreadyPaid = fields[15] as bool;
  }

  @override
  void write(BinaryWriter writer, Log obj) {
    writer
      ..writeByte(13)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.type)
      ..writeByte(2)
      ..write(obj.title)
      ..writeByte(3)
      ..write(obj.content)
      ..writeByte(4)
      ..write(obj.created)
      ..writeByte(5)
      ..write(obj.lastUpdate)
      ..writeByte(6)
      ..write(obj.tags)
      ..writeByte(8)
      ..write(obj.started)
      ..writeByte(9)
      ..write(obj.finished)
      ..writeByte(11)
      ..write(obj.deadline)
      ..writeByte(12)
      ..write(obj.completed)
      ..writeByte(14)
      ..write(obj.price)
      ..writeByte(15)
      ..write(obj.alreadyPaid);
  }
}
