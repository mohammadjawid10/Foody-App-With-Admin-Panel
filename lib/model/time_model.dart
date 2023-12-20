class GetTimeModel {
  List<TimeModel> time=[];

  GetTimeModel.empty();

  GetTimeModel({required this.time});

  GetTimeModel.fromJson(Map<String, dynamic> json) {
    if (json['time'] != null) {
      time = <TimeModel>[];
      json['time'].forEach((v) {
        time.add(TimeModel.fromJson(v));
      });
    }
  }

  @override
  String toString() {
    return 'GetTimeModel{time: $time}';
  }
}


class TimeModel{
  String time='';

  TimeModel({required this.time});

  TimeModel.empty();

  TimeModel.fromJson(Map<String, dynamic> json) {
    time = json['timevalue'];
  }

  @override
  String toString() {
    return 'TimeModel{time: $time}';
  }
}