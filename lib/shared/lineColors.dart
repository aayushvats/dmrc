import 'package:dmrc/models/databaseHelper.dart';
import 'package:dmrc/models/stationDetails.dart';
import 'package:flutter/material.dart';

// Define the enum
enum ColorName {
  LN1,
  LN1tint,
  LN2,
  LN2tint,
  LN3,
  LN3tint,
  LN4,
  LN4tint,
  LN5,
  LN5tint,
  LN6,
  LN6tint,
  LN7,
  LN7tint,
  LN8,
  LN8tint,
  LN9,
  LN9tint,
  LN10,
  LN10tint,
  LN11,
  LN11tint,
  LN12, //unknown line
  LN12tint, //unknown line
}

// Extension to get Color from the enum
extension ColorExtension on ColorName {
  Color get color {
    switch (this) {
      case ColorName.LN1:
        return Color(0xFFDA483B);
      case ColorName.LN1tint:
        return Color(0xFF562D2E);
      case ColorName.LN2:
        return Color(0xFFFFC718);
      case ColorName.LN2tint:
        return Color(0xFF615423);
      case ColorName.LN3:
        return Color(0xFF4486F4);
      case ColorName.LN3tint:
        return Color(0xFF294065);
      case ColorName.LN4:
        return Color(0xFF4486F4);
      case ColorName.LN4tint:
        return Color(0xFF294065);
      case ColorName.LN5:
        return Color(0xFF1CA45C);
      case ColorName.LN5tint:
        return Color(0xFF1D4938);
      case ColorName.LN6:
        return Color(0xFFA705AB);
      case ColorName.LN6tint:
        return Color(0xFF47194F);
      case ColorName.LN7:
        return Color(0xFFDA3BA4);
      case ColorName.LN7tint:
        return Color(0xFF562A4D);
      case ColorName.LN8:
        return Color(0xFFC1235C);
      case ColorName.LN8tint:
        return Color(0xFF4E2238);
      case ColorName.LN9:
        return Color(0xFF686868);
      case ColorName.LN9tint:
        return Color(0xFF33373B);
      case ColorName.LN10:
        return Color(0xFFFF9E0F);
      case ColorName.LN10tint:
        return Color(0xFF614721);
      case ColorName.LN11:
        return Color(0xFF44BFF4);
      case ColorName.LN11tint:
        return Color(0xFF295165);
      case ColorName.LN12:
        return Color(0xFF2EFFF2);
      case ColorName.LN12tint:
        return Color(0xFF226465);
      default:
        return Colors.black; // Fallback color
    }
  }
}

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

// Future<StationDetails> getCurrentStation() async {
//   print('Hello, World!');
//     String stationName = "AZU";
//   double latitude = 28.6663534; // Replace with the target latitude
//   double longitude = 77.228467;
//   DatabaseHelper dbHelper = DatabaseHelper();
//     String? stationID = await dbHelper.getStationInfo(stationName);
//     print("meowmeow in here--");
//     print(stationID);
//   dbHelper.getLineDetails("LN1");
//   dbHelper.getNearestStation(latitude, longitude);
//     if (stationID != null) {
//       return StationDetails(
//         stationID: stationID,
//         name: 'Azadpur',
//         isInterchange:true,
//         lines: ['LN2', 'LN6'],
//         stations1: ['ADN', 'MDT'],
//         stations2: ['MJP', 'SHB'],
//       );
//     }
//
//   return StationDetails(
//     stationID: "staionID",
//     name: 'meowmeow',
//     isInterchange: true,
//     lines: ['LN2', 'LN6'],
//     stations1: ['ADN', 'MDT'],
//     stations2: ['MJP', 'SHB'],
//   );
// }