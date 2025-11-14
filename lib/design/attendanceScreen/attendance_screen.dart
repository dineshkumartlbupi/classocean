
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class AttendanceScreen extends StatefulWidget {
  const AttendanceScreen({super.key});

  @override
  State<AttendanceScreen> createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  bool showCalendar = false;
  bool showClassSection = false;
  DateTime selectedDay = DateTime.now();
  String selectedClass = "Select Class";
  List<String> classSections = ["Class 6", "Class 6", "Class 7", "Class 8"];

  // Dummy periods
  List<String> periods = [
    "Period 1",
    "Period 2",
    "Period 3",
    "Period 4",
    "Period 5",
    "Period 6",
    "Period 7"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Attendance Marking",style: TextStyle(color: Colors.black,fontSize: 25),
          ),
        ),
        body: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                // Calendar toggle button
               /* ElevatedButton(
                  onPressed: () {
                    setState(() {
                      showCalendar = !showCalendar;
                    });
                  },
                  child: const Text("Select Date"),
                ),*/

                // Calendar visible when tapped
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  child: showCalendar
                      ? Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: TableCalendar(
                      focusedDay: selectedDay,
                      firstDay: DateTime(2020),
                      lastDay: DateTime(2100),
                      selectedDayPredicate: (day) => isSameDay(day, selectedDay),
                      onDaySelected: (selected, focused) {
                        setState(() {
                          selectedDay = selected;
                          showCalendar = false;
                        });
                      },
                    ),
                  )
                      : const SizedBox.shrink(),
                ),

                const SizedBox(height: 20),

                // Class selection button


                // Show class sections
                if (showClassSection)
                  Column(
                    children: classSections.map((section) {
                      return ListTile(
                        title: Text(section),
                        onTap: () {
                          setState(() {
                            selectedClass = section;
                            showClassSection = false;
                          });
                        },
                      );
                    }).toList(),
                  ),

                const SizedBox(height: 20),

                const Text(
                  "Periods",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 8),

                // Scrollable horizontal periods row
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: periods.map((period) {
                      return Container(
                        margin: const EdgeInsets.symmetric(horizontal: 6),
                        child: ElevatedButton(
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("Selected $period")),
                            );
                          },
                          child: Text(period),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
            ),
        );
    }
}
