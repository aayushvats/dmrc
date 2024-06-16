import 'package:dmrc/widgets/map/grid.dart';
import 'package:dmrc/widgets/map/normalStationPin.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../models/databaseHelper.dart';
import '../../models/stationDetails.dart';
import '../../shared/lineColors.dart';
import 'currentStationPin.dart';
import 'lines.dart';

class MetroMap extends StatefulWidget {
  const MetroMap({super.key, required this.currentStation});

  final StationDetails currentStation;

  @override
  State<MetroMap> createState() => _MetroMapState();
}

class _MetroMapState extends State<MetroMap> {
  bool isBuilt = false;
  StationDetails stations1_prev = StationDetails(
      stationID: '',
      name: '',
      isInterchange: false,
      lines: ['', ''],
      stations1: ['', '']);
  StationDetails stations1_next = StationDetails(
      stationID: '',
      name: '',
      isInterchange: false,
      lines: ['', ''],
      stations1: ['', '']);
  StationDetails? stations2_prev;
  StationDetails? stations2_next;

  @override
  void initState() {
    populateStations();
    super.initState();
  }

  populateStations() async {
    DatabaseHelper dbHelper = DatabaseHelper();

    print('reached here -> ${widget.currentStation.stations1}');
    if(widget.currentStation.stations1 != null){
      stations1_prev =
      await dbHelper.getStationInfo(widget.currentStation.stations1![0]!);
      stations1_next =
      await dbHelper.getStationInfo(widget.currentStation.stations1![1]!);
    }
    if (widget.currentStation.isInterchange) {
      print('isInterchange.. get more stations');
      stations2_prev =
          await dbHelper.getStationInfo(widget.currentStation.stations2![0]!);
      stations2_next =
          await dbHelper.getStationInfo(widget.currentStation.stations2![1]!);
    }
    setState(() {
      isBuilt = true;
    });
    ;
  }

  @override
  Widget build(BuildContext context) {
    return isBuilt
        ? Stack(
            children: [
              Grid(),

              //firstLine
              Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.width * 0.425),
                child: Transform.rotate(
                  angle: 30 * (3.1415926535 / 180),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 1.2,
                    height: 2,
                    child: CustomPaint(
                      painter: HorizontalLinePainter(
                        color: getLineColor(widget.currentStation.lines[0]),
                      ),
                    ),
                  ),
                ),
              ),

              //secondLine
              widget.currentStation.isInterchange
                  ? Padding(
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.width * 0.41),
                      child: Transform.rotate(
                        angle: 150 * (3.1415926535 / 180),
                        child: Container(
                          width: MediaQuery.of(context).size.width * 1.2,
                          height: 2,
                          child: CustomPaint(
                            painter: HorizontalLinePainter(
                              color:
                                  getLineColor(widget.currentStation.lines[1]),
                            ),
                          ),
                        ),
                      ),
                    )
                  : SizedBox.shrink(),

              //currStationNamef
              Padding(
                padding: EdgeInsets.only(
                  // left: (MediaQuery.of(context).size.width - 32)*0.5,
                  top: (MediaQuery.of(context).size.width - 98) * 0.5,
                ),
                child: Center(
                  child: Column(
                    children: [
                      CurrentStationPin(
                        lines: widget.currentStation.lines,
                      ),
                      Expanded(
                        child: Text(
                          "${widget.currentStation.name}",
                          style: TextStyle(
                              fontSize: 19,
                              color: CupertinoColors.white,
                              fontWeight: FontWeight.w600,
                              overflow: TextOverflow.ellipsis),
                        ),
                      )
                    ],
                  ),
                ),
              ),

              //top-left-interchange
              stations1_prev.isInterchange
                  ? Padding(
                      padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.width * 0.24,
                      ),
                      child: Transform.rotate(
                        angle: 120 * (3.1415926535 / 180),
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.3,
                          height: 2,
                          child: CustomPaint(
                            painter: HorizontalLinePainter(
                              color: getLineColor(
                                      "${stations1_prev.lines.firstWhere((element) => element != widget.currentStation.lines[0])}")
                                  .withOpacity(0.5),
                            ),
                          ),
                        ),
                      ),
                    )
                  : SizedBox.shrink(),

              //bottom-right-interchange
              stations1_next.isInterchange
                  ? Padding(
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.width * 0.61,
                          left: MediaQuery.of(context).size.width * 0.65),
                      child: Transform.rotate(
                        angle: 120 * (3.1415926535 / 180),
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.3,
                          height: 2,
                          child: CustomPaint(
                            painter: HorizontalLinePainter(
                              color: getLineColor(
                                      "${stations1_next.lines.firstWhere((element) => element != widget.currentStation.lines[0])}")
                                  .withOpacity(0.5),
                            ),
                          ),
                        ),
                      ),
                    )
                  : SizedBox.shrink(),

              //top-right-interchange
              widget.currentStation.isInterchange &&
                      stations2_prev!.isInterchange
                  ? Padding(
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.width * 0.24,
                          left: MediaQuery.of(context).size.width * 0.675),
                      child: Transform.rotate(
                        angle: 60 * (3.1415926535 / 180),
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.3,
                          height: 2,
                          child: CustomPaint(
                            painter: HorizontalLinePainter(
                              color: getLineColor(
                                      "${stations2_prev!.lines.firstWhere((element) => element != widget.currentStation.lines[0])}")
                                  .withOpacity(0.5),
                            ),
                          ),
                        ),
                      ),
                    )
                  : SizedBox.shrink(),

              //bottom-left-interchange
              widget.currentStation.isInterchange &&
                      stations2_next!.isInterchange
                  ? Padding(
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.width * 0.61,
                          left: MediaQuery.of(context).size.width * 0.025),
                      child: Transform.rotate(
                        angle: 60 * (3.1415926535 / 180),
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.3,
                          height: 2,
                          child: CustomPaint(
                            painter: HorizontalLinePainter(
                              color: getLineColor(
                                      "${stations2_next!.lines.firstWhere((element) => element != widget.currentStation.lines[0])}")
                                  .withOpacity(0.5),
                            ),
                          ),
                        ),
                      ),
                    )
                  : SizedBox.shrink(),

              //firstStations
              Padding(
                padding: EdgeInsets.only(
                  left: (MediaQuery.of(context).size.width) * 0.135,
                  right: (MediaQuery.of(context).size.width) * 0.155,
                  top: (MediaQuery.of(context).size.width) * 0.204,
                ),
                child: Row(
                  mainAxisAlignment: widget.currentStation.isInterchange
                      ? MainAxisAlignment.spaceBetween
                      : MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          NormalStationPin(
                            lines: stations1_prev?.lines ?? ['NIL'],
                          ),
                          Text(
                            "${stations1_prev?.name}",
                            style: TextStyle(
                              fontSize: 14,
                            ),
                            textAlign: TextAlign.start,
                          ),
                        ],
                      ),
                    ),
                    widget.currentStation.isInterchange
                        ? Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                NormalStationPin(
                                  lines: stations2_prev?.lines ?? ['NIL'],
                                ),
                                Text(
                                  "${stations2_prev?.name}",
                                  style: TextStyle(fontSize: 14),
                                  textAlign: TextAlign.end,
                                )
                              ],
                            ),
                          )
                        : SizedBox.shrink(),
                  ],
                ),
              ),

              //secondStations
              Padding(
                padding: EdgeInsets.only(
                  left: (MediaQuery.of(context).size.width) * 0.15,
                  right: (MediaQuery.of(context).size.width) * 0.17,
                  top: (MediaQuery.of(context).size.width) * 0.58,
                ),
                child: Row(
                  mainAxisAlignment: widget.currentStation.isInterchange
                      ? MainAxisAlignment.spaceBetween
                      : MainAxisAlignment.end,
                  children: [
                    widget.currentStation.isInterchange
                        ? Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                NormalStationPin(
                                  lines: stations2_next?.lines ?? ['NIL'],
                                ),
                                Text(
                                  "${stations2_next?.name}",
                                  style: TextStyle(
                                    fontSize: 14,
                                  ),
                                  textAlign: TextAlign.start,
                                ),
                              ],
                            ),
                          )
                        : SizedBox.shrink(),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          NormalStationPin(
                            lines: stations1_next?.lines ?? ['NIL'],
                          ),
                          Text(
                            "${stations1_next?.name}",
                            style: TextStyle(fontSize: 14),
                            textAlign: TextAlign.end,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )
        : Center(
            child: CircularProgressIndicator(
              color: Colors.white30,
            ),
          );
  }
}
