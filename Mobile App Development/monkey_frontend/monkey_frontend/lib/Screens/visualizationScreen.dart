import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_application_2/Screens/historyScreen.dart';
import 'package:flutter_application_2/Screens/homeScreen.dart';
import 'package:flutter_application_2/Screens/predictionScreen.dart';
import 'package:flutter_application_2/main.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class VisualizationScreen extends StatefulWidget {
  const VisualizationScreen({Key? key}) : super(key: key);

  @override
  _VisualizationScreenState createState() => _VisualizationScreenState();
}

class ChartData {
  final DateTime date;
  final double temperature;
  final double humidity;

  ChartData(this.date, this.temperature, this.humidity);
}

class _VisualizationScreenState extends State<VisualizationScreen> {
  final DatabaseReference dbRef =
      FirebaseDatabase.instance.ref().child('history');
  List<ChartData> chartData = [];

  int selectedIdHumidity = -1;
  int selectedIdTemperature = -1;

  int selectedMonthHumidity = DateTime.january;
  int selectedMonthTemperature = DateTime.january;

  @override
  void initState() {
    super.initState();
    _listenForFirebaseData();
  }

  void _listenForFirebaseData() {
    dbRef.onValue.listen((event) {
      final Iterable<DataSnapshot> snapshots = event.snapshot.children;
      chartData.clear();
      for (final snapshot in snapshots) {
        final Map history = snapshot.value as Map;
        if (history['date'] != null && history['temperature'] != null) {
          chartData.add(ChartData(DateTime.parse(history['date']),
              history['temperature'], history['humidity']));
        }
      }
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 3, 0, 33),
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(
            Icons.home_outlined,
            color: Colors.white,
          ),
          onPressed: () {
            // Navigate to the next screen when the button is pressed
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) {
                return const HomePage();
              },
            ));
          },
        ),
        title: Text(
          'Visualization',
          style: TextStyle(
              color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          //chart Name
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.all(10),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    '  Humidity Analysis',
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              DropdownButton<int>(
                value: selectedMonthHumidity,
                onChanged: (int? newValue) {
                  setState(() {
                    selectedMonthHumidity = newValue!;
                  });
                },
                items: [
                  DropdownMenuItem<int>(
                    value: DateTime.january,
                    child: Text(
                      'January',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                  DropdownMenuItem<int>(
                    value: DateTime.february,
                    child: Text(
                      'February',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                  DropdownMenuItem<int>(
                    value: DateTime.march,
                    child: Text(
                      'March',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),

          Expanded(
            flex: 3,
            child: Container(
              padding: EdgeInsets.all(10),
              child: Center(
                child: SfCartesianChart(
                  series: <LineSeries>[
                    LineSeries<ChartData, DateTime>(
                      dataSource: chartData
                        .where((data) => data.date.month == selectedMonthHumidity)
                        .toList(), // Filter data for the selected month
                      xValueMapper: (ChartData data, _) => data.date,
                      yValueMapper: (ChartData data, _) => data.humidity,
                      dataLabelSettings: DataLabelSettings(isVisible: false),
                    )
                  ],
                  primaryXAxis: DateTimeAxis(
                    dateFormat: DateFormat("d MMM"), 
                  ),
                  primaryYAxis: NumericAxis(
                    minimum: 20,
                  ),
                  // Customize chart appearance here (optional)
                ),
              ),
            ),
          ),

          //chart Name
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.all(10),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    ' Temperature Analysis',
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              DropdownButton<int>(
                value: selectedMonthTemperature,
                onChanged: (int? newValue) {
                setState(() {
                  selectedMonthTemperature = newValue!;
                });
              },
              items: [
                DropdownMenuItem<int>(
                  value: DateTime.january,
                  child: Text(
                    'January',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ),
                DropdownMenuItem<int>(
                  value: DateTime.february,
                  child: Text(
                    'February',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ),
                DropdownMenuItem<int>(
                  value: DateTime.march,
                  child: Text(
                    'March',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ),
                // Add more months as needed
                ],
              ),
            ],
          ),

          Expanded(
            flex: 3,
            child: Container(
              padding: EdgeInsets.all(10),
              child: Center(
                child: SfCartesianChart(
                  series: <ColumnSeries>[
                    ColumnSeries<ChartData, String>(
                      dataSource: chartData
                          .where((data) => data.date.month == selectedMonthTemperature)
                          .toList(), // Filter data for the selected month
                      xValueMapper: (ChartData data, _) =>
                          DateFormat('dd MMM').format(data.date),
                      yValueMapper: (ChartData data, _) => data.temperature,
                      // Hide data labels
                      dataLabelSettings: DataLabelSettings(isVisible: false),
                    )
                  ],
                  primaryXAxis: CategoryAxis(),
                  primaryYAxis: NumericAxis(),
                  // Customize chart appearance here (optional)
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: SafeArea(
          child: Container(
        padding: EdgeInsets.all(12),
        margin: EdgeInsets.symmetric(
          horizontal: 20,
        ),
        decoration: BoxDecoration(
            color: Color.fromARGB(255, 10, 3, 49),
            borderRadius: BorderRadius.all(Radius.circular(24))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            GNav(
                selectedIndex: 2,
                color: Colors.white, //other icon color
                activeColor: Colors.white, //Active icon color
                //tab
                tabBackgroundColor: Color.fromARGB(255, 44, 50, 102),
                gap: 8,
                onTabChange: (index) {
                  print(index);
                  switch (index) {
                    case 0:
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => PredictionScreen(),
                      ));
                      break;
                    case 1:
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => HistoryScreen(),
                      ));
                      break;
                    case 2:
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => VisualizationScreen(),
                      ));
                      break;
                  }
                },
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 05),
                tabs: const [
                  GButton(icon: Icons.batch_prediction, text: 'Prediction'),
                  GButton(icon: Icons.history, text: 'History'),
                  GButton(
                    icon: Icons.visibility,
                    text: 'Visualization',
                  ),
                ]),
          ],
        ),
      )),
    );
  }
}
