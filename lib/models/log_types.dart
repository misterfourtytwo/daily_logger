import 'package:hive/hive.dart';

part 'log_types.g.dart';

@HiveType(typeId: 1)
enum LogTypes {
  @HiveField(0)
  note,
  @HiveField(1)
  payment,
  @HiveField(2)
  task,
  @HiveField(3)
  continuous,
}
