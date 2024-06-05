import 'package:dmrc/shared/lineColors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../models/stationDetails.dart';

class CurrentStation extends StatefulWidget {
  const CurrentStation({super.key, required this.currentStation});
  final StationDetails currentStation;

  @override
  State<CurrentStation> createState() => _CurrentStationState();
}

class _CurrentStationState extends State<CurrentStation> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 18),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(12), // Adjust as needed
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
            blurRadius: 20,
            offset: Offset(0, 0),
          ),
        ],
      ),
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.all(15.0),
            child: Icon(
              Icons.train_outlined,
              size: 30,
              color: Colors.white70,
            ),
          ),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('CLOSEST STATION',
                  style: TextStyle(
                      fontSize: 13,
                      color: Colors.white70
                  ),
                ),
                Text(widget.currentStation.name,
                    style: const TextStyle(
                        fontSize: 25,
                        color: Colors.white70,
                        overflow: TextOverflow.ellipsis
                    ),
                ),
              ],
            ),
          ),
          if (widget.currentStation.isInterchange)
            Row(
              children: widget.currentStation.lines.map((line) => Padding(
                padding: EdgeInsets.only(left: 8.0),
                child: Icon(
                  Icons.circle_rounded,
                  size: 30,
                  color: getLineColor(line),
                ),
              )).toList(),
            ),
          SizedBox(
            width: 18,
          )
        ],
      ),
    );
  }
}
