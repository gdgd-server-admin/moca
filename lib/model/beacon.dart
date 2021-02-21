import 'package:hive/hive.dart';

@HiveType(typeId: 1)
class ReceivedBeacon extends HiveObject{
  
  @HiveField(0)
  DateTime recvDate;
  @HiveField(1)
  int rawMajor = 0;
  @HiveField(2)
  int rawMinor = 0;

  @HiveField(3)
  bool answer0 = false;
  @HiveField(4)
  bool answer1 = false;
  @HiveField(5)
  bool answer2 = false;
  @HiveField(6)
  bool answer3 = false;
  @HiveField(7)
  bool answer4 = false;
  @HiveField(8)
  bool answer5 = false;
  @HiveField(9)
  bool answer6 = false;
  @HiveField(10)
  bool answer7 = false;
  @HiveField(11)
  bool answer8 = false;
  @HiveField(12)
  bool answer9 = false;
  @HiveField(13)
  bool answer10 = false;
  @HiveField(14)
  bool answer11 = false;
  @HiveField(15)
  bool answer12 = false;
  @HiveField(16)
  bool answer13 = false;
  @HiveField(17)
  bool answer14 = false;
  @HiveField(18)
  bool answer15 = false;

  bool isExpanded = false;
}