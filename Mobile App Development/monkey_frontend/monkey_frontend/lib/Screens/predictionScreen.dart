import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/Screens/historyScreen.dart';
import 'package:flutter_application_2/Screens/homeScreen.dart';
import 'package:flutter_application_2/Screens/visualizationScreen.dart';
import 'package:flutter_application_2/main.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

// import 'package:google_nav_bar/google_nav_bar.dart';

class PredictionScreen extends StatefulWidget {
  const PredictionScreen({Key? key}) : super(key: key);

  @override
  State<PredictionScreen> createState() => _PredictionScreenState();
}

class _PredictionScreenState extends State<PredictionScreen> {
  Query dbRef = FirebaseDatabase.instance.reference();
  DatabaseReference reference = FirebaseDatabase.instance.reference();
  String? day0Namevalue;
  String? day0getvalue;
  String? day1Namevalue;
  String? day1getvalue;
  String? day2Namevalue;
  String? day2getvalue;
  String? day3Namevalue;
  String? day3getvalue;
  String? day4Namevalue;
  String? day4getvalue;
  String? day5Namevalue;
  String? day5getvalue;

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
          'Predictions',
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
            dynamic data = snapshot.value;

            // Check if the data is a map
            if (data is Map) {
              // Check if all day values are not null
              if (data['day0'] != null &&
                  data['day1'] != null &&
                  data['day2'] != null &&
                  data['day3'] != null &&
                  data['day4'] != null &&
                  data['day5'] != null) {
                // Assign values to day variables
                day0getvalue = data['day0'].toString();
                day1getvalue = data['day1'].toString();
                day2getvalue = data['day2'].toString();
                day3getvalue = data['day3'].toString();
                day4getvalue = data['day4'].toString();
                day5getvalue = data['day5'].toString();

                day0Namevalue = data['day0Name'].toString();
                day1Namevalue = data['day1Name'].toString();
                day2Namevalue = data['day2Name'].toString();
                day3Namevalue = data['day3Name'].toString();
                day4Namevalue = data['day4Name'].toString();
                day5Namevalue = data['day5Name'].toString();

                // Call _buildDay0Text method
                return _buildDay0Text(data);
              } else {
                // Handle the case where one or more day values are null
                return Center(
                  child: Text(''),
                );
              }
            } else {
              // Handle the case where the data is not in the expected format
              return Row();
            }
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

  Widget _buildDay0Text(Map<dynamic, dynamic> predictions) {
    return Padding(
      padding: const EdgeInsets.only(right: 30, left: 10, top: 30),
      child: Column(
        children: [
          Row(
            children: [
              SizedBox(
                width: 60,
              ),
              Text(
                day0Namevalue!,
                style:
                    const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                width: 23,
              ),
              Text(
                day1Namevalue!,
                style:
                    const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                width: 23,
              ),
              Text(
                day2Namevalue!,
                style:
                    const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                width: 23,
              ),
              Text(
                day3Namevalue!,
                style:
                    const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                width: 23,
              ),
              Text(
                day4Namevalue!,
                style:
                    const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                width: 23,
              ),
              Text(
                day5Namevalue!,
                style:
                    const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          SizedBox(
            height: 40,
          ),
          Row(
            children: [
              Text(
                'Loc 1',
                style:
                    const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                width: 26,
              ),
              if (day0getvalue == "0")
                Image.asset('assets/check.png', width: 20, height: 20)
              else
                Image.asset('assets/cross.png', width: 20, height: 20),
              SizedBox(
                width: 32,
              ),
              if (day1getvalue == "0")
                Image.asset('assets/check.png', width: 20, height: 20)
              else
                Image.asset('assets/cross.png', width: 20, height: 20),
              SizedBox(
                width: 37,
              ),
              if (day2getvalue == "0")
                Image.asset('assets/check.png', width: 20, height: 20)
              else
                Image.asset('assets/cross.png', width: 20, height: 20),
              SizedBox(
                width: 32,
              ),
              if (day3getvalue == "0")
                Image.asset('assets/check.png', width: 20, height: 20)
              else
                Image.asset('assets/cross.png', width: 20, height: 20),
              SizedBox(
                width: 27,
              ),
              if (day4getvalue == "0")
                Image.asset('assets/check.png', width: 20, height: 20)
              else
                Image.asset('assets/cross.png', width: 20, height: 20),
              SizedBox(
                width: 30,
              ),
              if (day5getvalue == "0")
                Image.asset('assets/check.png', width: 20, height: 20)
              else
                Image.asset('assets/cross.png', width: 20, height: 20),
            ],
          ),
          SizedBox(
            height: 40,
          ),
          Row(
            children: [
              Text(
                'Loc 2',
                style:
                    const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                width: 26,
              ),
              if (day0getvalue == "1")
                Image.asset('assets/check.png', width: 20, height: 20)
              else
                Image.asset('assets/cross.png', width: 20, height: 20),
              SizedBox(
                width: 32,
              ),
              if (day1getvalue == "1")
                Image.asset('assets/check.png', width: 20, height: 20)
              else
                Image.asset('assets/cross.png', width: 20, height: 20),
              SizedBox(
                width: 37,
              ),
              if (day2getvalue == "1")
                Image.asset('assets/check.png', width: 20, height: 20)
              else
                Image.asset('assets/cross.png', width: 20, height: 20),
              SizedBox(
                width: 32,
              ),
              if (day3getvalue == "1")
                Image.asset('assets/check.png', width: 20, height: 20)
              else
                Image.asset('assets/cross.png', width: 20, height: 20),
              SizedBox(
                width: 27,
              ),
              if (day4getvalue == "1")
                Image.asset('assets/check.png', width: 20, height: 20)
              else
                Image.asset('assets/cross.png', width: 20, height: 20),
              SizedBox(
                width: 30,
              ),
              if (day5getvalue == "1")
                Image.asset('assets/check.png', width: 20, height: 20)
              else
                Image.asset('assets/cross.png', width: 20, height: 20),
            ],
          ),
          SizedBox(
            height: 40,
          ),
          Row(
            children: [
              Text(
                'Loc 3',
                style:
                    const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                width: 26,
              ),
              if (day0getvalue == "2")
                Image.asset('assets/check.png', width: 20, height: 20)
              else
                Image.asset('assets/cross.png', width: 20, height: 20),
              SizedBox(
                width: 32,
              ),
              if (day1getvalue == "2")
                Image.asset('assets/check.png', width: 20, height: 20)
              else
                Image.asset('assets/cross.png', width: 20, height: 20),
              SizedBox(
                width: 37,
              ),
              if (day2getvalue == "2")
                Image.asset('assets/check.png', width: 20, height: 20)
              else
                Image.asset('assets/cross.png', width: 20, height: 20),
              SizedBox(
                width: 32,
              ),
              if (day3getvalue == "2")
                Image.asset('assets/check.png', width: 20, height: 20)
              else
                Image.asset('assets/cross.png', width: 20, height: 20),
              SizedBox(
                width: 27,
              ),
              if (day4getvalue == "2")
                Image.asset('assets/check.png', width: 20, height: 20)
              else
                Image.asset('assets/cross.png', width: 20, height: 20),
              SizedBox(
                width: 30,
              ),
              if (day5getvalue == "2")
                Image.asset('assets/check.png', width: 20, height: 20)
              else
                Image.asset('assets/cross.png', width: 20, height: 20),
            ],
          ),
          SizedBox(
            height: 40,
          ),
          Row(
            children: [
              Text(
                'Loc 4',
                style:
                    const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                width: 26,
              ),
              if (day0getvalue == "3")
                Image.asset('assets/check.png', width: 20, height: 20)
              else
                Image.asset('assets/cross.png', width: 20, height: 20),
              SizedBox(
                width: 32,
              ),
              if (day1getvalue == "3")
                Image.asset('assets/check.png', width: 20, height: 20)
              else
                Image.asset('assets/cross.png', width: 20, height: 20),
              SizedBox(
                width: 37,
              ),
              if (day2getvalue == "3")
                Image.asset('assets/check.png', width: 20, height: 20)
              else
                Image.asset('assets/cross.png', width: 20, height: 20),
              SizedBox(
                width: 32,
              ),
              if (day3getvalue == "3")
                Image.asset('assets/check.png', width: 20, height: 20)
              else
                Image.asset('assets/cross.png', width: 20, height: 20),
              SizedBox(
                width: 27,
              ),
              if (day4getvalue == "3")
                Image.asset('assets/check.png', width: 20, height: 20)
              else
                Image.asset('assets/cross.png', width: 20, height: 20),
              SizedBox(
                width: 30,
              ),
              if (day5getvalue == "3")
                Image.asset('assets/check.png', width: 20, height: 20)
              else
                Image.asset('assets/cross.png', width: 20, height: 20),
            ],
          ),
          SizedBox(
            height: 40,
          ),
          Row(
            children: [
              Text(
                'Loc 5',
                style:
                    const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                width: 26,
              ),
              if (day0getvalue == "4")
                Image.asset('assets/check.png', width: 20, height: 20)
              else
                Image.asset('assets/cross.png', width: 20, height: 20),
              SizedBox(
                width: 32,
              ),
              if (day1getvalue == "4")
                Image.asset('assets/check.png', width: 20, height: 20)
              else
                Image.asset('assets/cross.png', width: 20, height: 20),
              SizedBox(
                width: 37,
              ),
              if (day2getvalue == "4")
                Image.asset('assets/check.png', width: 20, height: 20)
              else
                Image.asset('assets/cross.png', width: 20, height: 20),
              SizedBox(
                width: 32,
              ),
              if (day3getvalue == "4")
                Image.asset('assets/check.png', width: 20, height: 20)
              else
                Image.asset('assets/cross.png', width: 20, height: 20),
              SizedBox(
                width: 27,
              ),
              if (day4getvalue == "4")
                Image.asset('assets/check.png', width: 20, height: 20)
              else
                Image.asset('assets/cross.png', width: 20, height: 20),
              SizedBox(
                width: 30,
              ),
              if (day5getvalue == "4")
                Image.asset('assets/check.png', width: 20, height: 20)
              else
                Image.asset('assets/cross.png', width: 20, height: 20),
            ],
          ),
          SizedBox(
            height: 40,
          ),
          Row(
            children: [
              Text(
                'Loc 6',
                style:
                    const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                width: 26,
              ),
              if (day0getvalue == "5")
                Image.asset('assets/check.png', width: 20, height: 20)
              else
                Image.asset('assets/cross.png', width: 20, height: 20),
              SizedBox(
                width: 32,
              ),
              if (day1getvalue == "5")
                Image.asset('assets/check.png', width: 20, height: 20)
              else
                Image.asset('assets/cross.png', width: 20, height: 20),
              SizedBox(width: 37),
              if (day2getvalue == "5")
                Image.asset('assets/check.png', width: 20, height: 20)
              else
                Image.asset('assets/cross.png', width: 20, height: 20),
              SizedBox(
                width: 32,
              ),
              if (day3getvalue == "5")
                Image.asset('assets/check.png', width: 20, height: 20)
              else
                Image.asset('assets/cross.png', width: 20, height: 20),
              SizedBox(
                width: 27,
              ),
              if (day4getvalue == "5")
                Image.asset('assets/check.png', width: 20, height: 20)
              else
                Image.asset('assets/cross.png', width: 20, height: 20),
              SizedBox(
                width: 30,
              ),
              if (day5getvalue == "5")
                Image.asset('assets/check.png', width: 20, height: 20)
              else
                Image.asset('assets/cross.png', width: 20, height: 20),
            ],
          ),
        ],
      ),
    );
  }
}
