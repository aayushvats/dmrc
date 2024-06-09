import 'package:dmrc/models/databaseHelper.dart';
import 'package:dmrc/models/stationDetails.dart';
import 'package:flutter/material.dart';

// Define the enum
enum ColorName {
  red,
  redtint,
  yellow,
  yellowtint,
  blue,
  bluetint,
  green,
  greentint,
  orange,
  orangetint,
  pink,
  pinktint,
  violet,
  violettint,
  magenta,
  magentatint,
  grey,
  greytint,
  aqua,
  aquatint,
  rapid,
  rapidtint,
}

// Extension to get Color from the enum
extension ColorExtension on ColorName {
  Color get color {
    switch (this) {
      case ColorName.red:
        return Color(0xFFDA483B);
      case ColorName.redtint:
        return Color(0xFF562D2E);
      case ColorName.yellow:
        return Color(0xFFFFC718);
      case ColorName.yellowtint:
        return Color(0xFF615423);
      case ColorName.blue:
        return Color(0xFF4486F4);
      case ColorName.bluetint:
        return Color(0xFF294065);
      case ColorName.green:
        return Color(0xFF1CA45C);
      case ColorName.greentint:
        return Color(0xFF1D4938);
      case ColorName.orange:
        return Color(0xFFFF9E0F);
      case ColorName.orangetint:
        return Color(0xFF614721);
      case ColorName.pink:
        return Color(0xFFDA3BA4);
      case ColorName.pinktint:
        return Color(0xFF562A4D);
      case ColorName.violet:
        return Color(0xFFA705AB);
      case ColorName.violettint:
        return Color(0xFF47194F);
      case ColorName.magenta:
        return Color(0xFFC1235C);
      case ColorName.magentatint:
        return Color(0xFF4E2238);
      case ColorName.grey:
        return Color(0xFF686868);
      case ColorName.greytint:
        return Color(0xFF33373B);
      case ColorName.rapid:
        return Color(0xFF44BFF4);
      case ColorName.rapidtint:
        return Color(0xFF295165);
      case ColorName.aqua:
        return Color(0xFF2EFFF2);
      case ColorName.aquatint:
        return Color(0xFF226465);
      default:
        return Colors.black; // Fallback color
    }
  }
}

// Function to get Color from a String
Color getLineColor(String colorString) {
  try {
    final colorName = ColorName.values.firstWhere(
          (e) => e.toString().split('.').last == colorString,
    );
    return colorName.color;
  } catch (e) {
    // If the string doesn't match any enum value, return a default color
    return Colors.black;
  }
}

Future<StationDetails> getCurrentStation() async {
  print('Hello, World!');
    String stationName = "AZU";
  double latitude = 28.6663534; // Replace with the target latitude
  double longitude = 77.228467;
  DatabaseHelper dbHelper = DatabaseHelper();
    String? stationID = await dbHelper.getStationInfo(stationName);
    print("meowmeow in here--");
    print(stationID);
  dbHelper.getLineDetails("LN1");
  dbHelper.getNearestStation(latitude, longitude);
    if (stationID != null) {
      return StationDetails(
        stationID: stationID,
        name: 'Azadpur',
        isInterchange:true,
        lines: ['yellow', 'pink'],
        stations1: ['ADN', 'MDT'],
        stations2: ['MJP', 'SHB'],
      );
    }

  return StationDetails(
    stationID: "staionID",
    name: 'meowmeow',
    isInterchange: true,
    lines: ['yellow', 'pink'],
    stations1: ['ADN', 'MDT'],
    stations2: ['MJP', 'SHB'],
  );
}