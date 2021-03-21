import 'package:hive/hive.dart';
import 'package:moca/model/checksheet.dart';

class CheckSheetAdapter extends TypeAdapter<CheckSheet>{
  @override
  CheckSheet read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };

    var result = CheckSheet();
    result.id = fields[0] as int;
    result.q1 = fields[1] as String;
    result.q2 = fields[2] as String;
    result.q3 = fields[3] as String;
    result.q4 = fields[4] as String;
    result.q5 = fields[5] as String;
    result.q6 = fields[6] as String;
    result.q7 = fields[7] as String;
    result.q8 = fields[8] as String;
    result.q9 = fields[9] as String;
    result.q10 = fields[10] as String;
    result.q11 = fields[11] as String;
    result.q12 = fields[12] as String;
    result.q13 = fields[13] as String;
    result.q14 = fields[14] as String;
    result.q15 = fields[15] as String;
    result.q16 = fields[16] as String;

    return result;
  }

  @override
  final int typeId = 2;

  @override
  void write(BinaryWriter writer, CheckSheet obj) {
    writer
    ..writeByte(17)
        ..writeByte(0)
        ..write(obj.id)
        ..writeByte(1)
        ..write(obj.q1)
        ..writeByte(2)
      ..write(obj.q2)
      ..writeByte(3)
      ..write(obj.q3)
      ..writeByte(4)
      ..write(obj.q4)
      ..writeByte(5)
      ..write(obj.q5)
      ..writeByte(6)
      ..write(obj.q6)
      ..writeByte(7)
      ..write(obj.q7)
      ..writeByte(8)
      ..write(obj.q8)
      ..writeByte(9)
      ..write(obj.q9)
      ..writeByte(10)
      ..write(obj.q10)
      ..writeByte(11)
      ..write(obj.q11)
      ..writeByte(12)
      ..write(obj.q12)
      ..writeByte(13)
      ..write(obj.q13)
      ..writeByte(14)
      ..write(obj.q14)
      ..writeByte(15)
      ..write(obj.q15)
      ..writeByte(16)
      ..write(obj.q16);
  }

}