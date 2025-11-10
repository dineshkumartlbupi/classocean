import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // User type selection
  String selectedType = "Students";
  // Controllers for both profiles
  final nameController = TextEditingController();
  final subjectController = TextEditingController();
  final periodController = TextEditingController();
  final rollNoController = TextEditingController();
  final classController = TextEditingController();
  final sectionController = TextEditingController();

  File? profileImage;

  // Pick image function
  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        profileImage = File(pickedImage.path);
      });
    }
  }

  void _saveProfile() {
    if (nameController.text.isEmpty) return;

    String message = selectedType == "Teacher"
        ? "Teacher.${nameController.text}\nSubject:${subjectController.text}"
        : "Student:${nameController.text}\nRoll No:${rollNoController.text}-${sectionController.text}";
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Profile Saved"),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Close"),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    subjectController.dispose();
    periodController.dispose();
    rollNoController.dispose();
    classController.dispose();
    sectionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Profile ",style: TextStyle(color: Color(0xff5DCCFC)),)),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            // Type switch
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Select Profile type:",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                DropdownButton<String>(
                  items: [
                    DropdownMenuItem(
                      value: "Students",
                      child: Text("Students"),
                    ),
                    DropdownMenuItem(value: "Teacher", child: Text("Teacher")),
                  ],
                  onChanged: (val) {
                    setState(() {
                      selectedType = val!;
                      // Clear all inputs when switching
                      nameController.clear();
                      subjectController.clear();
                      periodController.clear();
                      rollNoController.clear();
                      classController.clear();
                      sectionController.clear();
                    });
                  },
                ),
              ],
            ),
            SizedBox(height: 20),
            // Photo profile section
            GestureDetector(
              onTap: _pickImage,
              child: CircleAvatar(
                radius: 60,
                backgroundColor: Color(0xff5DCCFC),
                backgroundImage: profileImage != null
                    ? FileImage(profileImage!)
                    : null,
                child: profileImage == null
                    ? const Icon(
                        Icons.camera_alt,
                        size: 40,
                        color: Colors.white,
                      )
                    : null,
              ),
            ),
            // Form Fields (depends on type)
            SizedBox(height: 20,),
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: "Name",
                prefixIcon: Icon(Icons.person),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            if (selectedType == "Teacher") ...[
              TextField(
                controller: subjectController,
                decoration: InputDecoration(
                  labelText: "Subject",
                  prefixIcon: Icon(Icons.book),
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 10,),
              TextField(
                controller: subjectController,
                decoration: InputDecoration(
                  labelText: " Number of Periods",
                  prefixIcon: Icon(Icons.schedule),
                  border: OutlineInputBorder(),
                ),
              ),
            ],
           // SizedBox(height: 10,),
            if (selectedType == "Students") ...[
              TextField(
                controller: rollNoController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Roll Number",
                  prefixIcon: Icon(Icons.confirmation_number),
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 10,),
              TextField(
                controller: classController,
                decoration: InputDecoration(
                  labelText: "Class",
                  prefixIcon: Icon(Icons.group),
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 10,),
              TextField(
                controller: sectionController,
                decoration: InputDecoration(
                  labelText: "Section",
                  prefixIcon: Icon(Icons.group),
                  border: OutlineInputBorder(),
                ),
              ),
            ],
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: _saveProfile,
              label: Text("Save Profile"),
              style: ElevatedButton.styleFrom(

                minimumSize: Size(double.infinity, 48),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
