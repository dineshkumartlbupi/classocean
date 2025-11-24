import 'package:classocean/dashBoard/atten/attend_screen.dart';
import 'package:classocean/dashBoard/overview/overview_screen.dart';
import 'package:classocean/dashBoard/report/report_screen.dart';
import 'package:classocean/dashBoard/set_screen/set_screen.dart';

import 'package:classocean/design/profileScreen/profile_screen.dart';

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
        color: Colors.white,
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
          Icon(icon, color: color ?? Colors.indigo, size: 28),
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
          IconButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => ProfileScreen()),
              );
            },
            icon: Icon(Icons.menu, color: Colors.black),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(45),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: TabBar(
              controller: _tabController,
              labelColor: Colors.white,
              unselectedLabelColor: Colors.black,
              indicator: BoxDecoration(
                color: Colors.indigo,
                borderRadius: BorderRadius.circular(5),
              ),
              labelStyle: TextStyle(fontWeight: FontWeight.w600),
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
          //ProfileScreen(),
          //StudentScreen(),
          // Overview Tab
          /*SingleChildScrollView(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top starts
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: _buildStatCard(
                        "Students",
                        "",
                        Icons.show_chart,
                        color: Colors.green,
                      ),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: _buildStatCard(
                        "Classes Today",
                        "scheduled",
                        Icons.access_time,
                        color: Colors.indigo,
                      ),
                    ),
                    SizedBox(height: 24),
                    Text(
                      "Quick Actions",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 12),
                    GridView.count(
                      crossAxisSpacing: 12,
                      crossAxisCount: 2,
                      mainAxisSpacing: 12,
                      shrinkWrap: true,
                      childAspectRatio: 3,
                      children: [
                        _buildQuickActions(
                          Icons.check_circle,
                          "Mark Attendance",
                          "Quick check in",
                          Colors.white,
                          Colors.green,
                        ),
                        _buildQuickActions(
                          Icons.person_add,
                          "Add Student",
                          "New enrollment",
                          Colors.white,
                          Colors.indigo,
                        ),
                        _buildQuickActions(
                          Icons.bar_chart,
                          "View Reports",
                          "Analytics & insights",
                          Colors.white,
                          Colors.purple,
                        ),
                        _buildQuickActions(
                          Icons.notifications,
                          "Send Notice",
                          "Communicate",
                          Colors.white,
                          Colors.orange,
                        ),
                      ],
                    ),
                    SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Recent Activities",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          "View All",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.indigo,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 12),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(
                        vertical: 16,
                        horizontal: 20,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Text(
                        "Attendance Marked",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
                Center(child: Text("Attendance Screen"),),
                Center(child: Text("Reports Screen"),),
                Center(child: Text("Setting Screen"),),
              ],
            ),
          )*/
        ],
      ),
    );
  }
}
