class StationDetails {
  String stationID;
  String name;
  bool isInterchange;
  List<String> lines;
  List<String?>? stations1;
  List<String?>? stations2;
  List<String?>? stations3;

  StationDetails({
    required this.stationID,
    required this.name,
    required this.isInterchange,
    required this.lines,
    this.stations1,
    this.stations2,
    this.stations3,
  });

  // Factory method to create a StationDetails object from JSON
  factory StationDetails.fromJSON(Map<String, dynamic> json) {
    return StationDetails(
      stationID: json['stationID'],
      name: json['name'],
      isInterchange: json['isInterchange'],
      lines: List<String>.from(json['lines']),
      stations1: json['stations1'] != null ? List<String?>.from(json['stations1']) : null,
      stations2: json['stations2'] != null ? List<String?>.from(json['stations2']) : null,
      stations3: json['stations3'] != null ? List<String?>.from(json['stations3']) : null,
    );
  }

  // Method to convert a StationDetails object to JSON
  Map<String, dynamic> toJSON() {
    return {
      'stationID': stationID,
      'name': name,
      'isInterchange': isInterchange,
      'lines': lines,
      'stations1': stations1,
      'stations2': stations2,
      'stations3': stations3,
    };
  }
}
