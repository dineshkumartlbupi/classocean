/*

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class StudentScreen extends StatefulWidget {
  @override
  _StudentScreenState createState() => _StudentScreenState();
}

class _StudentScreenState extends State<StudentScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController classController = TextEditingController();
  final TextEditingController rollController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController fatherController = TextEditingController();
  final TextEditingController sectionController = TextEditingController();

  Future<void> saveStudent() async {
    await FirebaseFirestore.instance.collection('students').add({
      'name': nameController.text,
      'class': classController.text,
      'roll': rollController.text,
      'phone': phoneController.text,
      'father': fatherController.text,
      'section': sectionController.text,
    });

    nameController.clear();
    classController.clear();
    rollController.clear();
    phoneController.clear();
    fatherController.clear();
    sectionController.clear();

    Navigator.pop(context);
  }

  void openAddDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add Student'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(labelText: 'Name'),
                ),
                TextField(
                  controller: classController,
                  decoration: InputDecoration(labelText: 'Class'),
                ),
                TextField(
                  controller: rollController,
                  decoration: InputDecoration(labelText: 'Roll Number'),
                ),
                TextField(
                  controller: phoneController,
                  decoration: InputDecoration(labelText: 'Phone'),
                ),
                TextField(
                  controller: fatherController,
                  decoration: InputDecoration(labelText: "Father's Name"),
                ),
                TextField(
                  controller: sectionController,
                  decoration: InputDecoration(labelText: 'Section'),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancel'),
            ),
            ElevatedButton(onPressed: saveStudent, child: Text('Save')),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Students')),
      floatingActionButton: FloatingActionButton(
        onPressed: openAddDialog,
        child: Icon(Icons.add),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('students').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData)
            return Center(child: CircularProgressIndicator());

          return ListView(
            children: snapshot.data!.docs.map((doc) {
              String name = doc['name'];
              String firstLetter = name.isNotEmpty
                  ? name[0].toUpperCase()
                  : '?';

              return ListTile(
                leading: CircleAvatar(child: Text(firstLetter)),
                title: Text(doc['name']),
                subtitle: Text(
                  'Class: ${doc['class']}  | Roll: ${doc['roll']}\nPhone: ${doc['phone']}\nFather: ${doc['father']}  |  Section: ${doc['section']}',
                ),
                isThreeLine: true,
              );
            }).toList(),
          );
        },
      ),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StudentScreen extends StatefulWidget {
  const StudentScreen({super.key});

  @override
  State<StudentScreen> createState() => _StudentScreenState();
}

class _StudentScreenState extends State<StudentScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController rollController = TextEditingController();
  final TextEditingController fatherNameController = TextEditingController();
  String? selectedClass;
  String? selectedSection;
  final List<String> classList = List.generate(
    10,
    (index) => "Class${index + 1}",
  );
  Future<void> saveStudent() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Please login first!")));
      return;
    }
    await FirebaseFirestore.instance.collection("students").add({
      "name": nameController.text,
      "roll": rollController.text,
      "father": fatherNameController,
      "class": selectedClass,
      "section": selectedSection,
      "uid": user.uid,
      "createdAt": DateTime.now(),
    });
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text("Saved Students")));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("students Form"),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Form(
          child: Column(
            children: [
              ///Name Field
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: " Student Name",
                  border: OutlineInputBorder(),
                ),
                validator: (value) => value == null || value.isEmpty
                    ? "Enter the student name"
                    : null,
              ),
              SizedBox(height: 15,),
              TextFormField(
                controller: rollController,
                decoration: InputDecoration(
                  labelText: " Roll Number",
                  border: OutlineInputBorder(),
                ),
                validator: (value) => value == null || value.isEmpty
                    ? "Enter the roll number"
                    : null,
              ),
              SizedBox(height: 15,),
              TextFormField(
                controller: fatherNameController,
                decoration: InputDecoration(
                  labelText: " Father Name",
                  border: OutlineInputBorder(),
                ),
                validator: (value) => value == null || value.isEmpty
                    ? "Enter the father name"
                    : null,
              ),
              SizedBox(height: 15,),
             /// Class DropDown
              DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    labelText: "Select Class",
                    border: OutlineInputBorder(),
                  ),
                  value: selectedClass,
                  items: classList.map((cls)=>DropdownMenuItem(child: Text("cls"),value: cls,)).toList(),
                  onChanged: (value) => setState(() => selectedClass = value),
                validator: (value) => value == null ?"Select a Class": null,
              ),
              // Section DropDown
              SizedBox(height: 15,),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: "Select Section",
                  border: OutlineInputBorder(),
                ),
                value: selectedSection,
                items: classList.map((sec)=>DropdownMenuItem(child: Text("sec"),value: sec,)).toList(),
                onChanged: (value) => setState(() => selectedClass = value),
                validator: (value) => value == null ?"Select a Section": null,
              ),
              SizedBox(height: 25,),
              /// Save Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(onPressed: saveStudent,
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 15),
                    ),
                    child: Text("Save Student")),
              )
            ],
          ),
        ),
      ),
    );
  }
}
*/

import 'package:classocean/dashBoard/dashBoard_screen.dart';
import 'package:classocean/design/bottomnavscreen/bottom_nav_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class StudentScreen extends StatefulWidget {
  const StudentScreen({super.key});

  @override
  State<StudentScreen> createState() => _StudentScreenState();
}

class _StudentScreenState extends State<StudentScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController fatherController = TextEditingController();
  final TextEditingController rollController = TextEditingController();

  String? selectedClass;
  String? selectedSection;

  final List<String> classList = List.generate(10, (i) => "Class ${i + 1}");

  final List<String> sectionList = ["A", "B", "C", "D"];

  Future<void> saveStudent() async {
    if (!_formKey.currentState!.validate()) return;

    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Please login first.")));
      return;
    }

    final studentData = {
      "name": nameController.text,
      "fatherName": fatherController.text,
      "roll": rollController.text,
      "class": selectedClass,
      "section": selectedSection,
      "uid": user.uid,
      "createdAt": DateTime.now(),
    };

    // Save to Firebase Firestore
    await FirebaseFirestore.instance.collection("students").add(studentData);

    // Show dialog box with details
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text("Student Details Saved"),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Name: ${studentData['name']}"),
            Text("Roll No: ${studentData['roll']}"),
            Text("Father's Name: ${studentData['fatherName']}"),
            Text("Class: ${studentData['class']}"),
            Text("Section: ${studentData['section']}"),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("OK"),
          ),
        ],
      ),
    );

    // Clear form
    nameController.clear();
    fatherController.clear();
    rollController.clear();
    selectedClass = null;
    selectedSection = null;

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => BottomNavScreen()),
        );
        return false;
      },

      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Student Add", style: TextStyle(color: Colors.black)),
          backgroundColor: Color(0xFF5DCCFC),
        ),

        body: SingleChildScrollView(
          padding: EdgeInsets.all(18),
          child: Column(
            children: [
              /// --- FORM START ---
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    /// Student Name
                    TextFormField(
                      controller: nameController,
                      decoration: InputDecoration(
                        labelText: "Student Name",
                        border: OutlineInputBorder(),
                        prefixIconColor: Color(0xFF5DCCFC),
                      ),
                      validator: (v) =>
                          v!.isEmpty ? "Enter student name" : null,
                    ),
                    SizedBox(height: 12),

                    /// Father's Name
                    TextFormField(
                      controller: fatherController,
                      decoration: InputDecoration(
                        labelText: "Father's Name",
                        border: OutlineInputBorder(),
                      ),
                      validator: (v) =>
                          v!.isEmpty ? "Enter father's name" : null,
                    ),
                    SizedBox(height: 12),

                    /// Roll No
                    TextFormField(
                      controller: rollController,

                      decoration: InputDecoration(
                        labelText: "Roll Number",
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                      validator: (v) => v!.isEmpty ? "Enter roll number" : null,
                    ),
                    SizedBox(height: 12),

                    /// Class Dropdown
                    DropdownButtonFormField(
                      decoration: InputDecoration(
                        labelText: "Select Class",
                        border: OutlineInputBorder(),
                      ),
                      value: selectedClass,
                      items: classList
                          .map(
                            (e) => DropdownMenuItem(value: e, child: Text(e)),
                          )
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedClass = value as String;
                        });
                      },
                      validator: (v) => v == null ? "Select class" : null,
                    ),
                    SizedBox(height: 12),

                    /// Section Dropdown
                    DropdownButtonFormField(
                      decoration: InputDecoration(
                        labelText: "Select Section",
                        border: OutlineInputBorder(),
                      ),
                      value: selectedSection,
                      items: sectionList
                          .map(
                            (e) => DropdownMenuItem(value: e, child: Text(e)),
                          )
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedSection = value as String;
                        });
                      },
                      validator: (v) => v == null ? "Select section" : null,
                    ),
                    SizedBox(height: 100),

                    /// Save Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: saveStudent,
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Color(0xFF5DCCFC),
                          backgroundColor: Color(0xFF5DCCFC),
                          padding: EdgeInsets.only(
                            left: 120,
                            right: 120,
                            top: 13,
                            bottom: 13,
                          ),
                          shape: RoundedRectangleBorder(),

                          textStyle: TextStyle(
                            fontSize: 17,
                            color: Colors.black87,
                          ),
                        ),
                        child: Text(
                          "Save",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 25),

              /// Students List (Live From Firestore)
               StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection("students")
                  .orderBy("createdAt", descending: true)
                  .snapshots(),
              builder: (_, snapshot) {
                if (!snapshot.hasData) return CircularProgressIndicator();

                final docs = snapshot.data!.docs;

                if (docs.isEmpty) {
                  return Text(
                    "No students added yet.",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  );
                }

                return ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: docs.length,
                  itemBuilder: (_, i) {
                    final data = docs[i];
                    final name = data["name"];
                    final letter = name[0].toUpperCase();

                    return Card(
                      elevation: 3,
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Color(0xFF5DCCFC),
                          child: Text(
                            letter,
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        ),
                        title: Text(
                          name,
                          style: TextStyle(color: Colors.black87),
                        ),
                        subtitle: Text(
                          "Class: ${data['class']} | Section: ${data['section']}",
                          style: TextStyle(color: Colors.black87),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
            ],
          ),
        ),
      ),
    );
  }
}
