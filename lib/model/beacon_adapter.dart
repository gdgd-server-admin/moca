import 'package:hive/hive.dart';
import 'package:moca/model/beacon.dart';

class BeaconAdapter extends TypeAdapter<ReceivedBeacon> {
  @override
  ReceivedBeacon read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    var result = ReceivedBeacon();
    result.recvDate = fields[0] as DateTime;
    result.rawMajor = fields[1] as int;
    result.rawMinor = fields[2] as int;

    result.answer0 = fields[3] as bool;
    result.answer1 = fields[4] as bool;
    result.answer2 = fields[5] as bool;
    result.answer3 = fields[6] as bool;
    result.answer4 = fields[7] as bool;
    result.answer5 = fields[8] as bool;
    result.answer6 = fields[9] as bool;
    result.answer7 = fields[10] as bool;
    result.answer8 = fields[11] as bool;
    result.answer9 = fields[12] as bool;
    result.answer10 = fields[13] as bool;
    result.answer11 = fields[14] as bool;
    result.answer12 = fields[15] as bool;
    result.answer13 = fields[16] as bool;
    result.answer14 = fields[17] as bool;
    result.answer15 = fields[18] as bool;

    return result;
  }

  @override
  final int typeId = 1;

  @override
  void write(BinaryWriter writer, ReceivedBeacon obj) {
    writer
      ..writeByte(19)
      ..writeByte(0)
      ..write(obj.recvDate)
      ..writeByte(1)
      ..write(obj.rawMajor)
      ..writeByte(2)
      ..write(obj.rawMinor)
      ..writeByte(3)
      ..write(obj.answer0)
      ..writeByte(4)
      ..write(obj.answer1)
      ..writeByte(5)
      ..write(obj.answer2)
      ..writeByte(6)
      ..write(obj.answer3)
      ..writeByte(7)
      ..write(obj.answer4)
      ..writeByte(8)
      ..write(obj.answer5)
      ..writeByte(9)
      ..write(obj.answer6)
      ..writeByte(10)
      ..write(obj.answer7)
      ..writeByte(11)
      ..write(obj.answer8)
      ..writeByte(12)
      ..write(obj.answer9)
      ..writeByte(13)
      ..write(obj.answer10)
      ..writeByte(14)
      ..write(obj.answer11)
      ..writeByte(15)
      ..write(obj.answer12)
      ..writeByte(16)
      ..write(obj.answer13)
      ..writeByte(17)
      ..write(obj.answer14)
      ..writeByte(18)
      ..write(obj.answer15);
  }
}
