class LocationPoint {
  final int? id;
  final DateTime timestamp;
  final double latitude;
  final double longitude;
  final String? additionalData;

  LocationPoint({
    this.id,
    required this.timestamp,
    required this.latitude,
    required this.longitude,
    this.additionalData,
  });

  factory LocationPoint.fromMap(Map<String, dynamic> map) => LocationPoint(
    id: map['id'] as int,
    timestamp: DateTime.fromMillisecondsSinceEpoch(map['timestamp'] as int),
    latitude: map['latitude'] as double,
    longitude: map['longitude'] as double,
    additionalData: map['additionalData'] as String?,
  );

  Map<String, dynamic> toMap() => {
    'id': id,
    'timestamp': timestamp.millisecondsSinceEpoch,
    'latitude': latitude,
    'longitude': longitude,
    if (additionalData != null) 'additionalData': additionalData,
  };
}
