import 'package:classocean/design/attendanceScreen/attendance_screen.dart';
import 'package:classocean/design/homeScreen/home_screen.dart';
import 'package:classocean/design/profileScreen/profile_screen.dart';
import 'package:classocean/design/studentsScreen/students_screen.dart';
import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  Widget buildDashBoardCard({
    required String title,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 4,
        margin: EdgeInsets.all(10),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: color.withOpacity(0.1),
          ),
          padding: EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 48, color: color),
              SizedBox(height: 10),
              Text(
                title,
                style: TextStyle(
                  fontSize: 18,
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
    var _mediaQuery = MediaQuery.of(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,

        title: Text("DashBoard",style: TextStyle(color: Color(0xff5DCCFC)),),
      ),

      body: Center(
        child: GridView.count(

          crossAxisCount: 2,
          padding: EdgeInsets.all(16),
          children: [
            buildDashBoardCard(
              title: "Home",
              icon: Icons.home,
              color: Color(0xff5DCCFC),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomeScreen()),
                );
              },
            ),
            buildDashBoardCard(
              title: "Attendance",
              icon: Icons.check_circle_outline,
              color: Color(0xff5DCCFC),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AttendanceScreen()),
                );
              },
            ),
            buildDashBoardCard(
              title: "Students",
              icon: Icons.people_alt_outlined,
              color: Color(0xff5DCCFC),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => StudentScreen()),
                );
              },
            ),
            buildDashBoardCard(
              title: "Profile",
              icon: Icons.person_outline,
              color: Color(0xff5DCCFC),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfileScreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
