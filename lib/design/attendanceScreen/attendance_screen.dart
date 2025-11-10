import 'package:classocean/dashBoard/dashBoard_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AttendanceScreen extends StatefulWidget {
  const AttendanceScreen({super.key});

  @override
  State<AttendanceScreen> createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  // Sections data (dummy )
  final List<String> sections = [
    "Section A",
    "Section B",
    "Section C",
    "Section D",
  ];
  String selectedSection = "Section A";

  // Students data (dummy)
  final List<String> students = [
    "Ayush Pandey",
    "Krishna Pandey",
    "Abhisekh",
    "Ankit",
    "Ashutosh",
    "Abhijeet",
    "Abhay",
  ];

  // Date
  DateTime selectedDate = DateTime.now();

  // Attendance Map :{student : [bool for each period]}
  final Map<String, List<bool>> attendanceData = {};
  @override
  void initState() {
    super.initState();
    _initializeAttendance();
  }

  void _initializeAttendance() {
    for (var student in students) {
      attendanceData[student] = List.generate(7, (context) => false);
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2026),
      lastDate: DateTime(2035),
    );
    if (picked != null) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  void _resetAttendance() {
    setState(() {
      for (var student in students) {
        attendanceData[student] = List.generate(7, (context) => false);
      }
    });
  }

  void _showSummary() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Attendance Summary"),
          content: SizedBox(
            width: double.maxFinite,
            child: ListView(
              shrinkWrap: true,
              children: students.map((student) {
                final attendance = attendanceData[student]!;
                final presentCount = attendance.where((p) => p).length;
                return ListTile(
                  title: Text(student),
                  subtitle: Text("Present in $presentCount / 7 periods"),
                );
              }).toList(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AttendanceScreen()),
                );
              },
              child: Text("Close"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final dateText = DateFormat('ddMMMyyyy').format(selectedDate);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text("Attendance "),
        actions: [
          IconButton(
            onPressed: () {
              _showSummary();
            },
            icon: Icon(Icons.list_alt),
            tooltip: "View Summary",
          ),
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => DashboardScreen()),
              );
            },
            icon: Icon(Icons.refresh),
            tooltip: "Reset",
          ),
        ],
      ),
      body: Column(
        children: [
          // Date & Section Selector
          Container(
            color: Color(0xff5DCCFC),
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "$dateText",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                ElevatedButton.icon(
                  onPressed: () => _selectDate(context),
                  icon: Icon(Icons.calendar_today, size: 18),
                  label: Text("Change Date"),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: DropdownButtonFormField<String>(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Select Section",
              ),
              value: selectedSection,
              items: sections.map((section) {
                return DropdownMenuItem(value: section, child: Text(section));
              }).toList(),
              onChanged: (val) {
                if (val != null) {
                  setState(() {
                    selectedSection = val;
                  });
                }
              },
            ),
          ),
          // Table Header
          Container(
            color: Colors.blue.shade200,
            padding: EdgeInsets.all(8),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    "Student",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                  child: Text(
                    "Periods(1-7)",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: students.length,
              itemBuilder: (context, index) {
                final student = students[index];
                final attendance = attendanceData[student]!;
                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(6.0),
                    child: Row(
                      children: [
                        Expanded(flex: 2, child: Text("Student")),
                        Expanded(
                          flex: 5,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: List.generate(7, (periodIndex) {
                              final isPresent = attendance[periodIndex];
                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    attendance[periodIndex] = !isPresent;
                                  });
                                },
                                child: CircleAvatar(
                                  radius: 14,
                                  backgroundColor: isPresent
                                      ? Colors.green
                                      : Colors.red,
                                  child: Text(
                                    '${periodIndex + 1}',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              );
                            }),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
