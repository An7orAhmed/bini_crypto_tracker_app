import 'dart:convert';

class Log {
  int rowid;
  String time;
  String name;
  double rate;
  Log({
    required this.rowid,
    required this.time,
    required this.name,
    required this.rate,
  });

  Log copyWith({
    int? rowid,
    String? time,
    String? name,
    double? rate,
  }) {
    return Log(
      rowid: rowid ?? this.rowid,
      time: time ?? this.time,
      name: name ?? this.name,
      rate: rate ?? this.rate,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'rowid': rowid,
      'time': time,
      'name': name,
      'rate': rate,
    };
  }

  factory Log.fromMap(Map<String, dynamic> map) {
    return Log(
      rowid: map['rowid'] as int,
      time: map['time'] as String,
      name: map['name'] as String,
      rate: map['rate'] as double,
    );
  }

  String toJson() => json.encode(toMap());

  factory Log.fromJson(String source) => Log.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Log(rowid: $rowid, time: $time, name: $name, rate: $rate)';
  }

  @override
  bool operator ==(covariant Log other) {
    if (identical(this, other)) return true;

    return other.rowid == rowid && other.time == time && other.name == name && other.rate == rate;
  }

  @override
  int get hashCode {
    return rowid.hashCode ^ time.hashCode ^ name.hashCode ^ rate.hashCode;
  }
}
