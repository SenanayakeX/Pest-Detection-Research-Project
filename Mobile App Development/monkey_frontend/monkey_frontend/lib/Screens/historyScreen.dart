import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_2/Screens/homeScreen.dart';
import 'package:flutter_application_2/Screens/predictionScreen.dart';
import 'package:flutter_application_2/Screens/visualizationScreen.dart';
import 'package:flutter_application_2/main.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:intl/intl.dart';
// import 'package:google_nav_bar/google_nav_bar.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  Query dbRef = FirebaseDatabase.instance.ref().child('history');
  DatabaseReference reference =
      FirebaseDatabase.instance.ref().child('history');

  Widget listItem({required Map history}) {
    String timestamp = history['date'] ?? ''; // Ensure date is not null

    // Parse the timestamp string to a DateTime object
    DateTime? dateTime = DateTime.tryParse(timestamp);

    // Format the DateTime object to display only the date part
    String formattedDate = dateTime != null
        ? DateFormat('yyyy-MM-dd').format(dateTime)
        : 'No date available';

    return Container(
        margin: const EdgeInsets.all(10),
        //padding: const EdgeInsets.all(20),
        //color: Color.fromARGB(255, 78, 210, 197),
        child: Card(
          color: Color.fromARGB(255, 235, 230, 230),
          elevation: 8,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Container(
            constraints: BoxConstraints(maxWidth: 300),
            child: ExpansionTile(
              title: Row(
                children: [
                  Text(
                    'Date: ' + formattedDate,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              children: <Widget>[
                Row(
                  children: [
                    SizedBox(width: 40),
                    Container(
                      width: 150,
                      child: Text(
                        'Device ID: ',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Expanded(
                      child: Text(history['device']?.toString() ??
                          'No device available'),
                    )
                  ],
                ),
                Row(
                  children: [
                    SizedBox(width: 40),
                    Container(
                      width: 150,
                      child: Text(
                        'Humidity: ',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        (history['humidity']?.toString() ??
                                'No humidity available') +
                            ' %',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w400),
                      ),
                    )
                  ],
                ),
                Row(
                  children: [
                    SizedBox(width: 40),
                    Container(
                      width: 150,
                      child: Text(
                        'Temperature: ',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        (history['temperature']?.toString() ??
                                'No temperature available') +
                            '\u00B0C',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w400),
                      ),
                    )
                  ],
                ),
                SizedBox(height: 10)
              ],
            ),
          ),
        ));
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
          'History',
          style: TextStyle(
              color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        height: double.infinity,
        child: FirebaseAnimatedList(
          query: dbRef,
          itemBuilder: (BuildContext context, DataSnapshot snapshot,
              Animation<double> animation, int index) {
            Map history = snapshot.value as Map;
            history['key'] = snapshot.key;

            return listItem(history: history);
          },
        ),
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
                selectedIndex: 1,
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
