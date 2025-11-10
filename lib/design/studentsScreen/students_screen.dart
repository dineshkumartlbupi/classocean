import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class StudentScreen extends StatefulWidget {
  const StudentScreen({super.key});

  @override
  State<StudentScreen> createState() => _StudentScreenState();
}

class _StudentScreenState extends State<StudentScreen> {
  // List of teachers for assigning
  final List<String> teachers = [
    "Mr. Smith",
    "Ms. Johnson",
    "Mrs. Lee",
    "Mr. Brown",
  ];

  // List of students
  final List<Map<String, dynamic>> students = [
    {
      "name": "Alice",
      "fatherName": "Robert",
      "motherName": "Sophia",
      "class": "4A",
      "dob": "15 Mar 2015",
      "teacher": "Mr. Smith",
    },
    {
      "name": "Bob",
      "fatherName": "John",
      "motherName": "Emma",
      "class": "4B",
      "dob": "12 Jan 2015",
      "teacher": "Ms. Johnson",
    },
  ];

  // Controllers for adding a new student
  final TextEditingController nameController = TextEditingController();
  final TextEditingController fatherController = TextEditingController();
  final TextEditingController motherController = TextEditingController();
  final TextEditingController classController = TextEditingController();

  DateTime? selectedDOB;

  void _selectDOB(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2015, 1),
      firstDate: DateTime(2010),
      lastDate: DateTime(2025),
    );

    if (picked != null) {
      setState(() {
        selectedDOB = picked;
      });
    }
  }

  void _addStudentDialog() {
    nameController.clear();
    fatherController.clear();
    motherController.clear();
    classController.clear();
    selectedDOB = null;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Add New Student"),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(labelText: "Student Name"),
                ),
                TextField(
                  controller: fatherController,
                  decoration: const InputDecoration(labelText: "Father's Name"),
                ),
                TextField(
                  controller: motherController,
                  decoration: const InputDecoration(labelText: "Mother's Name"),
                ),
                TextField(
                  controller: classController,
                  decoration: const InputDecoration(labelText: "Class"),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Text(
                      selectedDOB == null
                          ? "Select Date of Birth"
                          : "DOB: ${DateFormat('dd MMM yyyy').format(selectedDOB!)}",
                    ),
                    IconButton(
                      icon: const Icon(Icons.date_range),
                      onPressed: () => _selectDOB(context),
                    ),
                  ],
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                if (nameController.text.isNotEmpty &&
                    fatherController.text.isNotEmpty &&
                    motherController.text.isNotEmpty &&
                    classController.text.isNotEmpty &&
                    selectedDOB != null) {
                  setState(() {
                    students.add({
                      "name": nameController.text,
                      "fatherName": fatherController.text,
                      "motherName": motherController.text,
                      "class": classController.text,
                      "dob": DateFormat('dd MMM yyyy').format(selectedDOB!),
                      "teacher": teachers.first,
                    });
                  });
                  Navigator.pop(context);
                }
              },
              child: const Text("Add"),
            ),
          ],
        );
      },
    );
  }

  void _assignTeacher(String studentName, String teacherName) {
    setState(() {
      final student = students.firstWhere(
        (element) => element["name"] == studentName,
      );
      student["teacher"] = teacherName;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Students")),
      body: students.isEmpty
          ? const Center(child: Text("No students added yet."))
          : ListView.builder(
              itemCount: students.length,
              itemBuilder: (context, index) {
                final student = students[index];
                return Card(
                  elevation: 4,
                  margin: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          student["name"],
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text("Father's Name: ${student["fatherName"]}"),
                        Text("Mother's Name: ${student["motherName"]}"),
                        Text("Class: ${student["class"]}"),
                        Text("Date of Birth: ${student["dob"]}"),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Assigned Teacher:",
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                            DropdownButton<String>(
                              value: student["teacher"],
                              items: teachers
                                  .map(
                                    (t) => DropdownMenuItem(
                                      value: t,
                                      child: Text(t),
                                    ),
                                  )
                                  .toList(),
                              onChanged: (val) {
                                if (val != null) {
                                  _assignTeacher(student["name"], val);
                                }
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _addStudentDialog,
        icon: const Icon(Icons.add),
        label: const Text("Add Student"),
      ),
    );
  }
}
