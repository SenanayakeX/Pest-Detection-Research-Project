import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_2/Screens/historyScreen.dart';
import 'package:flutter_application_2/Screens/predictionScreen.dart';
import 'package:flutter_application_2/Screens/visualizationScreen.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
          'Monkey Detection',
          style: TextStyle(
              color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const SizedBox(
              height: 30,
            ),
            SizedBox(
              width: 300,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PredictionScreen()));
                },
                child: Text(
                  'Prediction',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 16, 20, 67),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            SizedBox(
              width: 300,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => HistoryScreen()));
                },
                child: Text(
                  'History',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 16, 20, 67),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            SizedBox(
              width: 300,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => VisualizationScreen()));
                },
                child: Text(
                  'Visualization',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 16, 20, 67),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
              ),
            ),
          ],
        ),
      ),
      // bottomNavigationBar: SafeArea(
      //     child: Container(
      //   padding: EdgeInsets.all(12),
      //   margin: EdgeInsets.symmetric(
      //     horizontal: 20,
      //   ),
      //   decoration: BoxDecoration(
      //       color: Color.fromARGB(255, 10, 3, 49),
      //       borderRadius: BorderRadius.all(Radius.circular(24))),
      //   child: Row(
      //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //     children: [
      //       GNav(
      //           color: Colors.white, //other icon color
      //           activeColor: Colors.white, //Active icon color
      //           //tab
      //           tabBackgroundColor: Color.fromARGB(255, 44, 50, 102),
      //           gap: 8,
      //           onTabChange: (index) {
      //             print(index);
      //             switch (index) {
      //               case 0:
      //                 Navigator.of(context).push(MaterialPageRoute(
      //                   builder: (context) => PredictionScreen(),
      //                 ));
      //                 break;
      //               case 1:
      //                 Navigator.of(context).push(MaterialPageRoute(
      //                   builder: (context) => HistoryScreen(),
      //                 ));
      //                 break;
      //               case 2:
      //                 Navigator.of(context).push(MaterialPageRoute(
      //                   builder: (context) => VisualizationScreen(),
      //                 ));
      //                 break;
      //             }
      //           },
      //           padding: EdgeInsets.symmetric(horizontal: 20, vertical: 05),
      //           tabs: const [
      //             GButton(icon: Icons.batch_prediction, text: 'Prediction'),
      //             GButton(icon: Icons.history, text: 'History'),
      //             GButton(
      //               icon: Icons.visibility,
      //               text: 'Visualization',
      //             ),
      //           ]),
      //     ],
      //   ),
      // )),
    );
  }
}