import 'package:dmrc/shared/lineColors.dart';
import 'package:flutter/material.dart';

class CurrentStationPin extends StatefulWidget {
  const CurrentStationPin({super.key, required this.lines});

  final List<String> lines;

  @override
  State<CurrentStationPin> createState() => _CurrentStationPinState();
}

class _CurrentStationPinState extends State<CurrentStationPin> {
  @override
  Widget build(BuildContext context) {
    return widget.lines.length < 3
        ? Stack(
            children: [
              Container(
                padding: EdgeInsets.all(3),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: getLineColor(widget.lines[0]),
                    width: 2,
                  ),
                ),
                child: Container(
                  width: 15,
                  height: 15,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: getLineColor(widget.lines[0]),
                  ),
                ),
              ),
              widget.lines.length == 2
                  ? ClipRect(
                      clipper: _HalfClipper(),
                      child: Container(
                        padding: EdgeInsets.all(
                            3), // Distance between the circle and the border
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: getLineColor(widget.lines[1]), // Border color
                            width: 2, // Border width
                          ),
                        ),
                        child: Container(
                          width: 15,
                          height: 15,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: getLineColor(widget.lines[1]), // Circle color
                          ),
                        ),
                      ),
                    )
                  : SizedBox.shrink(),
            ],
          )
        : SizedBox.shrink();
  }
}

class _HalfClipper extends CustomClipper<Rect> {
  @override
  Rect getClip(Size size) {
    return Rect.fromLTWH(0, 0, size.width, size.height / 2);
  }

  @override
  bool shouldReclip(CustomClipper<Rect> oldClipper) {
    return false;
  }
}
