import 'package:classocean/design/studentsScreen/student_screen.dart';
import 'package:flutter/material.dart';

class OverviewScreen extends StatelessWidget {
  const OverviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      backgroundColor: const Color(0xFFF7F9FB),
      
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: Container(
        padding: const EdgeInsets.all(1),
        decoration: BoxDecoration(
          color: const Color(0xFF2F6BFF),
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.blue.withOpacity(0.3),
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.add, color: Colors.white),
            TextButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => StudentScreen()),
                );
              },
              child: Text(
                "Quick Add",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
            ),

           /* Text(
              "Quick Add",
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            )*/
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ---------------- TOP ROW CARDS ----------------
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _statCard(
                  icon: Icons.trending_up,
                  iconBg: const Color(0xFFE6F6EF),
                  iconColor: Colors.green,
                  lineColor: Colors.green,
                  title: "Students Present",
                  subtitle: "",
                ),
                _statCard(
                  icon: Icons.access_time,
                  iconBg: const Color(0xFFE6EDFF),
                  iconColor: Colors.blue,
                  lineColor: Colors.blue,
                  title: "Classes Today",
                  subtitle: "scheduled",
                ),
              ],
            ),

            const SizedBox(height: 30),

            // ---------------- QUICK ACTIONS TITLE ----------------
            const Text(
              "Quick Actions",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: Color(0xFF101623),
              ),
            ),

            const SizedBox(height: 18),

            // ---------------- QUICK ACTIONS GRID ----------------
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              crossAxisSpacing: 14,
              mainAxisSpacing: 14,
              childAspectRatio: 1.2,
              children: [
                _quickAction(
                  icon: Icons.check_circle,
                  iconColor: Colors.green,
                  iconBg: const Color(0xFFEAF7ED),
                  title: "Mark Attendance",
                  subtitle: "Quick check-in",
                  borderColor: Colors.green.shade200,
                ),
                _quickAction(
                  icon: Icons.person_add_alt,
                  iconColor: Colors.blue,
                  iconBg: const Color(0xFFEAF0FF),
                  title: "Add Student",
                  subtitle: "New enrollment",
                  borderColor: Colors.blue.shade200,
                ),
                _quickAction(
                  icon: Icons.bar_chart,
                  iconColor: Colors.purple,
                  iconBg: const Color(0xFFF3E9FF),
                  title: "View Reports",
                  subtitle: "Analytics & insights",
                  borderColor: Colors.purple.shade200,
                ),
                _quickAction(
                  icon: Icons.notifications,
                  iconColor: Colors.orange,
                  iconBg: const Color(0xFFFFF0DD),
                  title: "Send Notice",
                  subtitle: "Communicate",
                  borderColor: Colors.orange.shade200,
                ),
              ],
            ),

            const SizedBox(height: 30),

            // ---------------- RECENT ACTIVITIES ----------------
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  "Recent Activities",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF101623),
                  ),
                ),
                Text(
                  "View All",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.blue,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // ---------------- ACTIVITY ITEM ----------------
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 12,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: const Text(
                "Attendance Marked",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF101623),
                ),
              ),
            ),
            SizedBox(height: 3),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 12,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: const Text(
                "New Student Enrolled",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF101623),
                ),
              ),
            ),
            SizedBox(height: 3),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 12,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: const Text(
                "Report Generated",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF101623),
                ),
              ),
            ),

            const SizedBox(height: 80), // space above floating button
          ],
        ),
      ),
    );
  }

  // ---------------- STAT CARD (TOP TWO) ----------------
  Widget _statCard({
    required IconData icon,
    required Color iconBg,
    required Color iconColor,
    required Color lineColor,
    required String title,
    required String subtitle,
  }) {
    return Container(
      width: 160,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 25,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  color: iconBg,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(icon, color: iconColor, size: 22),
              ),
              Container(height: 3, width: 20, color: lineColor),
            ],
          ),
          const SizedBox(height: 20),
          Container(height: 4, width: 40, color: Colors.black87),
          const SizedBox(height: 12),
          Text(
            title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          if (subtitle.isNotEmpty) ...[
            const SizedBox(height: 3),
            Text(
              subtitle,
              style: TextStyle(fontSize: 15, color: Colors.grey.shade500),
            ),
          ],
          const SizedBox(height: 10),
          Container(height: 2, width: 25, color: Colors.grey.shade400),
        ],
      ),
    );
  }

  // ---------------- QUICK ACTION CARD (GRID) ----------------
  Widget _quickAction({
    required IconData icon,
    required Color iconColor,
    required Color iconBg,
    required String title,
    required String subtitle,
    required Color borderColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: borderColor, width: 1.3),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 42,
            width: 42,
            decoration: BoxDecoration(
              color: iconBg,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(icon, color: iconColor, size: 22),
          ),
          const SizedBox(height: 12),
          Text(
            title,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Color(0xFF101623),
            ),
          ),
          const SizedBox(height: 2),
          Text(subtitle, style: TextStyle(color: Colors.grey.shade500)),
        ],
      ),
    );
  }
}
