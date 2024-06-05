import 'package:dmrc/shared/lineColors.dart';
import 'package:flutter/material.dart';

class NormalStationPin extends StatefulWidget {
  const NormalStationPin({super.key, required this.lines});

  final List<String> lines;

  @override
  State<NormalStationPin> createState() => _NormalStationPinState();
}

class _NormalStationPinState extends State<NormalStationPin> {
  @override
  Widget build(BuildContext context) {
    return widget.lines.length < 3
        ? Stack(
      children: [
        Container(
          padding: EdgeInsets.all(3),
          child: Container(
            width: 15,
            height: 15,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: getLineColor("${widget.lines[0]}tint"),
            ),
          ),
        ),
        widget.lines.length == 2
            ? ClipRect(
          clipper: _HalfClipper(),
          child: Container(
            padding: EdgeInsets.all(
                3),
            child: Container(
              width: 15,
              height: 15,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: getLineColor("${widget.lines[1]}tint"),
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
