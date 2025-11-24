import 'package:classocean/design/attendanceScreen/attendance_screen.dart';
import 'package:classocean/design/profileScreen/profile_screen.dart';
import 'package:classocean/design/studentsScreen/student_screen.dart';
import 'package:classocean/home/fees_screen.dart';
import 'package:classocean/home/notice_screen.dart';
import 'package:classocean/home/time_table_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  Widget buildCard({
    required String title,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: color.withOpacity(0.1),
          ),
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 40, color: color),
              SizedBox(height: 10),
              Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: Text("Home Screen")),
      body: GridView.count(
        crossAxisCount: 2,
        padding: EdgeInsets.all(16),
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        children: [
          buildCard(
            title: "Attendance",
            icon: Icons.check_circle_outline,
            color: Colors.green,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AttendanceScreen()),
              );
            },
          ),

          buildCard(
            title: "Students",
            icon: Icons.people_outline,
            color: Colors.blue,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) =>  StudentScreen()),
              );
            },
          ),
          buildCard(
            title: "Timetable",
            icon: Icons.calendar_today,
            color: Colors.orange,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => TimeTableScreen()),
              );
            },
          ),
          buildCard(
            title: "Fees",
            icon: Icons.account_balance_wallet_outlined,
            color: Colors.purple,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const FeesScreen()),
              );
            },
          ),
          buildCard(
            title: "Notices",
            icon: Icons.notifications_active_outlined,
            color: Colors.red,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => NoticeScreen()),
              );
            },
          ),
          buildCard(
            title: "Profile",
            icon: Icons.person_outline,
            color: Colors.teal,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ProfileScreen()),
              );
            },
          ),
        ],
      ),
    );
  }
}
