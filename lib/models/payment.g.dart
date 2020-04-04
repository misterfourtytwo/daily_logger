// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PaymentAdapter extends TypeAdapter<Payment> {
  @override
  final typeId = 2;

  @override
  Payment read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Payment(
      fields[0] as double,
      fields[1] as String,
    )..timestamp = fields[2] as DateTime;
  }

  @override
  void write(BinaryWriter writer, Payment obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.value)
      ..writeByte(1)
      ..write(obj.currency)
      ..writeByte(2)
      ..write(obj.timestamp);
  }
}
