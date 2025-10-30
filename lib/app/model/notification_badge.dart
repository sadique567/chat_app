import 'package:flutter/material.dart';

class NotificationBadge extends StatelessWidget {
  // also take a total notifction value
  final int totalNotificat;
   NotificationBadge({Key? key , required this.totalNotificat}) :super(key: key);


  @override
  Widget build(BuildContext context) {
    return Container(
width: 40,
height: 40,
decoration: BoxDecoration(
  color: Colors.orange,
  shape: BoxShape.circle
),
child: Center(
  child: 
  Padding(padding: 
  EdgeInsets.all(8) , child: Text("$totalNotificat"),),
),

    );
  }
  

}