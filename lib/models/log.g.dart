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
    return Log(
      id: fields[0] as String,
      title: fields[1] as String,
      content: fields[2] as String,
      tags: (fields[5] as List)?.cast<String>(),
      created: fields[3] as DateTime,
    )
      ..lastUpdate = fields[4] as DateTime
      ..isInstant = fields[6] as bool
      ..started = fields[7] as DateTime
      ..finished = fields[8] as DateTime
      ..isTask = fields[9] as bool
      ..deadline = fields[10] as DateTime
      ..completed = fields[11] as bool
      ..isPayment = fields[12] as bool
      ..price = fields[13] as Currency
      ..isPaid = fields[14] as bool;
  }

  @override
  void write(BinaryWriter writer, Log obj) {
    writer
      ..writeByte(15)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.content)
      ..writeByte(3)
      ..write(obj.created)
      ..writeByte(4)
      ..write(obj.lastUpdate)
      ..writeByte(5)
      ..write(obj.tags)
      ..writeByte(6)
      ..write(obj.isInstant)
      ..writeByte(7)
      ..write(obj.started)
      ..writeByte(8)
      ..write(obj.finished)
      ..writeByte(9)
      ..write(obj.isTask)
      ..writeByte(10)
      ..write(obj.deadline)
      ..writeByte(11)
      ..write(obj.completed)
      ..writeByte(12)
      ..write(obj.isPayment)
      ..writeByte(13)
      ..write(obj.price)
      ..writeByte(14)
      ..write(obj.isPaid);
  }
}
