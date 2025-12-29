import 'package:classocean/dashBoard/atten/attend_screen.dart';
import 'package:classocean/dashBoard/overview/overview_screen.dart';
import 'package:classocean/dashBoard/report/report_screen.dart';
import 'package:classocean/dashBoard/set_screen/set_screen.dart';
import 'package:classocean/design/profileScreen/profile_screen.dart';
import 'package:classocean/design/studentsScreen/data_screen.dart';
import 'package:classocean/design/studentsScreen/student_screen.dart';
import 'package:flutter/material.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Widget _buildStatCard(
    String title,
    String subtitle,
    IconData icon, {
    Color? color,
  }) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 5,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color ?? Colors.indigo, size: 20),
          SizedBox(height: 12),
          Text(
            title,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 4),
          Text(subtitle, style: TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }

  Widget _buildQuickActions(
    IconData icon,
    String title,
    String subtitle,
    Color bgColor,
    Color iconColor,
  ) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: iconColor, size: 22),
          ),
          SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
              ),
              Text(
                subtitle,
                style: TextStyle(color: Colors.grey, fontSize: 13),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      drawer: buildAppDrawer(context),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        titleSpacing: 16,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Good Morning",
              style: TextStyle(color: Colors.grey, fontSize: 14),
            ),
            Text(
              "Kulbhaskar Ashram \n PG College",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                height: 1.2,
              ),
            ),
          ],
        ),
        actions: [
          Stack(
            children: [
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.notifications_none),
                color: Colors.black,
              ),
              Positioned(
                right: 10,
                top: 10,
                child: Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ],
          ),
          CircleAvatar(
            radius: 18,
            backgroundColor: Colors.teal,
            child: Text("LA", style: TextStyle(color: Colors.white)),
          ),
          // Menu button opens Drawer
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.circle, color: Colors.white),
          ),
        ],

        bottom: PreferredSize(
          preferredSize: Size.fromHeight(45),
          child: Padding(
            padding: EdgeInsets.all(6),
            child: TabBar(
              controller: _tabController,
              isScrollable: true, // new add
              labelColor: Colors.white,
              labelPadding: EdgeInsets.symmetric(horizontal: 10),
              unselectedLabelColor: Colors.black,
              indicator: BoxDecoration(
                color: Color(0xFF5DCCFC),
                borderRadius: BorderRadius.circular(40),
              ),
              indicatorPadding: EdgeInsets.symmetric(
                horizontal: -6,
                vertical: 4,
              ),
              labelStyle: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: Colors.grey,
              ),
              tabs: [
                Tab(text: "Overview"),
                Tab(text: "Attendance"),
                Tab(text: "Reports"),
                Tab(text: "Settings"),
              ],
            ),
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          OverviewScreen(),
          AttendScreen(),
          ReportScreen(),
          SetScreen(),
        ],
      ),
    );
  }
}

Drawer buildAppDrawer(BuildContext context) {
  return Drawer(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topRight: Radius.circular(40),
        bottomRight: Radius.circular(40),
      ),
    ),
    child: Column(
      children: [
        SizedBox(height: 10),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF1565C0), Color(0xFF00C49A)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.only(topRight: Radius.circular(40)),
          ),

          child: Row(
            children: [
              CircleAvatar(
                radius: 28,
                backgroundColor: Colors.white.withOpacity(0.3),
                child: Text(
                  "LA",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Lavkush",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    "Kulbhaskar Ashram PG College",
                    style: TextStyle(color: Colors.white, fontSize: 13),
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: 10),

        Expanded(
          child: ListView(
            padding: EdgeInsets.symmetric(vertical: 10),
            children: [
              buildDrawerItem(Icons.grid_view, "Overview", () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DashboardScreen()),
                );
              }),
              buildDrawerItem(Icons.check_circle, "Attendance", () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AttendScreen()),
                );
              }),
              buildDrawerItem(Icons.bar_chart, "Reports", () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ReportScreen()),
                );
              }),
              buildDrawerItem(Icons.settings, "Settings", () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfileScreen()),
                );
              }),
              buildDrawerItem(Icons.person_add_alt, "Student", () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DataScreen()),
                );
              }),
              buildDrawerItem(Icons.school, "School", () {}),
            ],
          ),
        ),
        Divider(height: 1),
        Padding(
          padding: EdgeInsets.all(20),
          child: Row(
            children: [
              Icon(Icons.logout, color: Colors.red),
              SizedBox(width: 10),
              Text(
                "Logout",
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget buildDrawerItem(IconData icon, String text, VoidCallback onTap) {
  return ListTile(
    leading: Icon(icon, color: Colors.blue, size: 26),
    title: Text(
      text,
      style: TextStyle(
        fontSize: 16,
        color: Colors.black87,
        fontWeight: FontWeight.w500,
      ),
    ),
    onTap: onTap,
  );
}
