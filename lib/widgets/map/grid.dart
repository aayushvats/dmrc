import 'package:flutter/material.dart';

import 'lines.dart';

class Grid extends StatefulWidget {
  const Grid({super.key});

  @override
  State<Grid> createState() => _GridState();
}

class _GridState extends State<Grid> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*0.18),
          child: Row(
            children: List.generate(
              5,
              (index) {
                return Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * 0.06),
                  child: Container(
                    height: MediaQuery.of(context).size.width * 0.9,
                    width: 2,
                    child: CustomPaint(
                      painter: VerticalLinePainter(
                        color:
                            const Color(0xFF38414B),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            vertical: MediaQuery.of(context).size.width*0.11,
              horizontal: MediaQuery.of(context).size.width*0.075),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
              children: List.generate(
            5,
            (index) {
              return Padding(
                padding: EdgeInsets.symmetric(
                    vertical: MediaQuery.of(context).size.width * 0.06),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.85,
                  height: 2,
                  child: CustomPaint(
                    painter: HorizontalLinePainter(
                      color: Color(0xFF38414B),
                    ),
                  ),
                ),
              );
            },
          )),
        ),
      ],
    );
  }
}