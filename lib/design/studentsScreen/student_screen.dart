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
