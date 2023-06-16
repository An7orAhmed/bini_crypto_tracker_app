import 'dart:convert';

class Rate {
  String id;
  double usd;
  double usd_24h_change;
  Rate({
    required this.id,
    required this.usd,
    required this.usd_24h_change,
  });

  Rate copyWith({
    String? id,
    double? currentRate,
    double? oneDayDelta,
  }) {
    return Rate(
      id: id ?? this.id,
      usd: currentRate ?? usd,
      usd_24h_change: oneDayDelta ?? usd_24h_change,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'usd': usd,
      'usd_24h_change': usd_24h_change,
    };
  }

  factory Rate.fromMap(Map<String, dynamic> map) {
    return Rate(
      id: map['id'] as String,
      usd: map['usd'] as double,
      usd_24h_change: map['usd_24h_change'] as double,
    );
  }

  String toJson() => json.encode(toMap());

  factory Rate.fromJson(String source) => Rate.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Rate(id: $id, usd: $usd, usd_24h_change: $usd_24h_change)';

  @override
  bool operator ==(covariant Rate other) {
    if (identical(this, other)) return true;

    return other.id == id && other.usd == usd && other.usd_24h_change == usd_24h_change;
  }

  @override
  int get hashCode => id.hashCode ^ usd.hashCode ^ usd_24h_change.hashCode;
}
