import 'package:flutter/material.dart';

class AlertList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(4.0),
      padding: const EdgeInsets.all(2.0),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 115, 148, 170),
        borderRadius: BorderRadius.circular(10.0),
      ),
      height: 200,
      child: Column(
        children: <Widget>[
          Flexible(
            flex: 1,
            child: Row(
              children: <Widget>[
                _buildStatCard('Alerts', const Color.fromARGB(255, 115, 148, 170)),
              ],
            ),
          ),
          Flexible(
            flex: 3,
            child: ListView(
              padding: const EdgeInsets.all(0),
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                          width: 2, color: const Color.fromARGB(255, 88, 114, 132)),
                      color: const Color.fromARGB(255, 115, 148, 170)),
                  height: 40,
                  child: Center(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(
                        Icons.fireplace,
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Text(
                        'Heat is over 45 degree!',
                        style: TextStyle(
                            fontSize: 22,
                            color: Colors.white,
                            fontStyle: FontStyle.italic),
                      )
                    ],
                  )),
                ),
                Container(
                  margin: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                          width: 2, color: const Color.fromARGB(255, 88, 114, 132)),
                      color: const Color.fromARGB(255, 115, 148, 170)),
                  height: 40,
                  child: Center(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(
                        Icons.battery_alert,
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Text(
                        'Low Battery!',
                        style: TextStyle(
                            fontSize: 22,
                            color: Colors.white,
                            fontStyle: FontStyle.italic),
                      )
                    ],
                  )),
                ),
                Container(
                  margin: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                          width: 2, color: const Color.fromARGB(255, 88, 114, 132)),
                      color: const Color.fromARGB(255, 115, 148, 170)),
                  height: 40,
                  child: Center(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(
                        Icons.signal_cellular_off,
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Text(
                        'Signal Loss!',
                        style: TextStyle(
                            fontSize: 22,
                            color: Colors.white,
                            fontStyle: FontStyle.italic),
                      )
                    ],
                  )),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Expanded _buildStatCard(String title, Color color) {
    return Expanded(
      child: Container(
        height: 50,
        alignment: Alignment.center,
        margin: const EdgeInsets.all(1.0),
        padding: const EdgeInsets.all(2.0),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 28.0,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
