import 'package:classocean/dashBoard/dashBoard_screen.dart';
import 'package:classocean/dashBoard/overview/overview_screen.dart';
import 'package:classocean/design/attendanceScreen/attendance_screen.dart';
import 'package:classocean/design/profileScreen/profile_screen.dart';
import 'package:classocean/design/studentsScreen/students_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BottomNavScreen extends StatefulWidget {
  const BottomNavScreen({super.key});

  @override
  State<BottomNavScreen> createState() => _BottomNavScreenState();
}

class _BottomNavScreenState extends State<BottomNavScreen> {
  int currentIndex = 0;
  List<Widget> pages = [
    DashboardScreen(),
    StudentScreen(),
    AttendanceScreen(),
    ProfileScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.black87,
        unselectedItemColor: Colors.black87,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: Colors.black87),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_2_outlined, color: Colors.black87),
            label: "Student",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline, color: Colors.black87),
            label: "Attendance",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person, color: Colors.black87),
            label: "Profile",
          ),
        ],
        currentIndex: currentIndex,
        onTap: (value) {
          setState(() {
            currentIndex = value;
          });

        },
      ),
      body: IndexedStack(children: pages, index: currentIndex),
    );
  }
}
