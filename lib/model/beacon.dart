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

  /// rawMinorに格納されている数値を16個のフラグ値に展開する
  void ExtractMinor(){
    var bufString = rawMinor.toRadixString(2).padLeft(16,'0');
    answer0 = bufString[15] == "1";
    answer1 = bufString[14] == "1";
    answer2 = bufString[13] == "1";
    answer3 = bufString[12] == "1";
    answer4 = bufString[11] == "1";
    answer5 = bufString[10] == "1";
    answer6 = bufString[9] == "1";
    answer7 = bufString[8] == "1";
    answer8 = bufString[7] == "1";
    answer9 = bufString[6] == "1";
    answer10 = bufString[5] == "1";
    answer11 = bufString[4] == "1";
    answer12 = bufString[3] == "1";
    answer13 = bufString[2] == "1";
    answer14 = bufString[1] == "1";
    answer15 = bufString[0] == "1";
  }
}