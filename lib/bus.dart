import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BusPage extends StatefulWidget {
  const BusPage({super.key});

  @override
  State<BusPage> createState() => _BusPageState();
}

List<String> timebus = [
  "7.15",
  "7.30",
  "7.45",
  "8.00",
  "8.15",
  "8.30",
  "8.45",
  "9.00",
  "9.15",
  "9.30",
  "9.45",
  "10.00",
  "10.15",
  "10.30",
  "10.45",
  "11.00",
  "11.15",
  "11.30",
  "11.45",
  "12.00",
  "12.15",
  "12.30",
  "12.45",
  "13.00",
  "13.15",
  "13.30",
  "13.45",
  "14.00",
  "14.15",
  "14.30",
  "14.45",
  "15.00",
  "15.15",
  "15.30",
  "15.45",
  "16.00",
  "16.15",
  "16.30",
  "16.45",
  "17.00",
  "17.15",
  "17.30",
  "17.45",
  "18.00",
  "18.15",
  "18.30",
  "18.45",
  "19.00",
  "19.15",
  "19.30",
  "19.45",
  "20.00",
  "20.15",
  "20.30",
];

DateTime currentDate = DateTime.now();

List<DateTime> dateTimes = timebus.map((time) {
  final parts = time.split('.');
  final hour = int.parse(parts[0]);
  final minute = int.parse(parts[1]);

  return DateTime(
    currentDate.year,
    currentDate.month,
    currentDate.day,
    hour,
    minute,
  );
}).toList();

class _BusPageState extends State<BusPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  Container(
              margin: EdgeInsets.only(bottom: 100),
              child:CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            pinned: true,
            backgroundColor: Color.fromARGB(255, 255, 255, 255), 
            expandedHeight: 80, 
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: Text(
                "ตารางเวลารถตะลัย",
                style: TextStyle(
                  fontSize: 20,
                  color: const Color(0xFFEE008E),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              margin: EdgeInsets.only(bottom: 150),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    ...dateTimes.asMap().entries.map((entry) {
                      final int index = entry.key;
                      final DateTime time = entry.value;
                      return Padding(
                        padding: const EdgeInsets.only(
                            top: 25.0, left: 15, right: 15),
                        child: Container(
                          height: 55,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: getcolor(time, index),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          padding: EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "สาย1และสาย2 : ",
                                style: TextStyle(
                                  color: getcolorText(time, index),
                                  fontSize: 17,
                                ),
                              ),
                              Text(
                                DateFormat('HH:mm').format(time),
                                style: TextStyle(
                                  color: getcolorText(time, index),
                                  fontSize: 18.5,
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    ));
  }
  

  getcolor(DateTime time, int i) {
    DateTime t;
    if (i == dateTimes.length - 1) {
      t = dateTimes[i].add(Duration(minutes: 15));
    } else {
      t = dateTimes[i + 1];
    }
    if (currentDate.isAfter(time) && t.isAfter(currentDate)) {
      return Color.fromARGB(192, 238, 0, 143);
    } else {
      return Color.fromARGB(255, 255, 255, 255);
    }
  }

  getcolorText(DateTime time, int i) {
    DateTime t;
    if (i == dateTimes.length - 1) {
      t = dateTimes[i].add(Duration(minutes: 15));
    } else {
      t = dateTimes[i + 1];
    }
    if (currentDate.isAfter(time) && t.isAfter(currentDate)) {
      return Color.fromARGB(255, 255, 255, 255);
    } else {
      return Color.fromARGB(255, 0, 0, 0);
    }
  }
  
}
