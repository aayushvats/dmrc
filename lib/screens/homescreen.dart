import 'package:dmrc/models/stationDetails.dart';
import 'package:dmrc/shared/lineColors.dart';
import 'package:dmrc/widgets/currentStation.dart';
import 'package:dmrc/widgets/map/map.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  late StationDetails demoStation;
  @override
  void initState() {
    returnStation();
    super.initState();
  }
  void returnStation() async {

    setState(()  {

      demoStation = StationDetails(
        stationID: "AZU",
        name: 'Azadpur',
        isInterchange: true,
        lines: ['yellow', 'pink'],
        stations1: ['ADN', 'MDT'],
        stations2: ['MJP', 'SHB'],
      );

    });
    getCurrentStation();
  }

  final List<String> savedStations = ['AZADPUR', 'KASHMERE GATE', 'ROHINI EAST', 'KASHMERE GATE'];
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            Container(
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
              child: InkWell(
                onTap: (){
                  _scaffoldKey.currentState?.openDrawer();
                },
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Icon(
                    Icons.sort,
                    color: Colors.white70,
                  ),
                ),
              ),
            ),
            Expanded(
              child: CurrentStation(currentStation: demoStation),
            ),
          ],
        ),
      ),
      drawer: Drawer(
        backgroundColor: Theme.of(context).canvasColor,
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Theme.of(context).canvasColor,
              ),
              child: Column(
                children: [
                  MetroMap(currentStation: demoStation,),
                  Text(
                    demoStation.name,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Home'),
              onTap: () {
                // Handle the home tap here
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
              onTap: () {
                // Handle the settings tap here
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          MetroMap(
            currentStation: demoStation,
          ),
          Column(
            children: [
              Expanded(
                flex: 10,
                child: SizedBox(),
              ),
              Container(
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
                child: Padding(
                  padding: EdgeInsets.all(10.0),
                  child: InkWell(
                    onTap: (){
                      print("Clicked Map");
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(CupertinoIcons.map, color: CupertinoColors.white, size: 18,),
                        Text(' MAP', style: TextStyle(color: CupertinoColors.white),),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 12,
                child: Container(
                  margin: EdgeInsets.only(top: 10, bottom: 35, left: 25, right: 25),
                  padding: EdgeInsets.only(top: 25, bottom: 15, left: 25, right: 25),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(30), // Adjust as needed
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.25),
                        blurRadius: 20,
                        offset: Offset(0, 0),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      //FROM
                      Row(
                        children: [
                          Text(
                            'FROM',
                            style: TextStyle(
                                color: CupertinoColors.white,
                                fontSize: 14
                            ),
                          ),
                        ],
                      ),

                      //ENTER-BOX
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Color(0xFF1E1E1E),
                                  borderRadius: BorderRadius.circular(12), // Adjust as needed
                                ),
                                child: const Padding(
                                  padding: EdgeInsets.all(5.0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Icon(
                                        Icons.my_location,
                                        color: Colors.transparent,
                                        size: 32,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox( width: 8,),
                            Container(
                              decoration: BoxDecoration(
                                color: Theme.of(context).canvasColor,
                                borderRadius: BorderRadius.circular(12), // Adjust as needed
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Transform.rotate(
                                  angle: 30 * (3.1415926535 / 180),
                                  child: Icon(
                                    Icons.my_location,
                                    color: getLineColor('green'),
                                    size: 32,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      //TO
                      Row(
                        children: [
                          Text(
                            'TO',
                            style: TextStyle(
                                color: CupertinoColors.white,
                                fontSize: 14
                            ),
                          ),
                        ],
                      ),

                      //ENTER-BOX
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Color(0xFF1E1E1E),
                                  borderRadius: BorderRadius.circular(12), // Adjust as needed
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Icon(
                                        Icons.my_location,
                                        color: Colors.transparent,
                                        size: 32,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox( width: 8,),
                            Container(
                              decoration: BoxDecoration(
                                color: Theme.of(context).canvasColor,
                                borderRadius: BorderRadius.circular(12), // Adjust as needed
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Transform.rotate(
                                  angle: 310 * (3.1415926535 / 180),
                                  child: Icon(
                                    CupertinoIcons.arrow_turn_down_right,
                                    color: getLineColor('green'),
                                    size: 32,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      //PREVIOUS
                      Divider(
                        color: Colors.white30,
                      ),
                      Stack(
                        children: [
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: savedStations.map(
                                      (station) => Container(
                                    margin: EdgeInsets.only(top: 8, bottom: 8, right: 8),
                                    padding: EdgeInsets.only(top: 5, bottom: 5),
                                    decoration: BoxDecoration(
                                        color: Colors.transparent,
                                        borderRadius: BorderRadius.circular(6),
                                        border: Border.all(color: Colors.white30)
                                    ),
                                    child: Text("  $station  ", style: TextStyle(fontSize: 12, color: Colors.white30),),
                                  )).toList()
                            ),
                          ),
                          IgnorePointer(
                            child: Container(
                              height: 45,
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      decoration: const BoxDecoration(
                                        gradient: LinearGradient(
                                          colors: [Colors.black, Colors.transparent],
                                          begin: Alignment.centerRight,
                                          end: Alignment.center,
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          Container(
                            height: 41,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                InkWell(
                                  onTap: (){
                                    print("clicked Add Station");
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Theme.of(context).canvasColor,
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: const Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Icon(
                                        CupertinoIcons.add,
                                        color: Colors.white60,
                                        size: 20,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Divider(
                        color: Colors.white30,
                      ),

                      //EXPANDED
                      Expanded(child: Placeholder()),

                      //BUTTON
                      ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(Theme.of(context).canvasColor),
                        ),
                          onPressed: (){},
                          child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.manage_search_outlined,
                            color: getLineColor('green'),
                          ),
                          Text(
                            " SEARCH STATION",
                            style: TextStyle(
                              color: getLineColor('green'),
                            ),
                          ),
                        ],
                      ))
                    ],
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
