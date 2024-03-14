class ImportantEvent {
  String eventName;
  DateTime eventDate;

  ImportantEvent({
    required this.eventName,
    required this.eventDate,
  });

  factory ImportantEvent.fromJson(Map<String, dynamic> json) {
    return ImportantEvent(
      eventName: json['eventName'] as String,
      eventDate: DateTime.parse(json['eventDate'] as String),
    );
  }

  Map<String, dynamic> toJson() => {
    'eventName': eventName,
    'eventDate': eventDate.toIso8601String(),
  };
}
