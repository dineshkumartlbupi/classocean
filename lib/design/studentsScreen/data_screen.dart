import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class DataScreen extends StatefulWidget {
  const DataScreen({super.key});

  @override
  State<DataScreen> createState() => _DataScreenState();
}

class _DataScreenState extends State<DataScreen> {
  final studentsRef = FirebaseFirestore.instance.collection('students');
  final attendanceRef = FirebaseFirestore.instance.collection('attendance');

  DateTime selectedDate = DateTime.now();

  String get dateId => DateFormat('yyyy-MM-dd').format(selectedDate);

  final ImagePicker _picker = ImagePicker();

  // --- Pick a local image file using image_picker (gallery)
  Future<File?> _pickLocalImage() async {
    final XFile? picked = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );
    if (picked == null) return null;
    return File(picked.path);
  }

  // --- Upload file to Firebase Storage and return download URL
  Future<String> _uploadFile(File file) async {
    final fileName =
        'student_images/${DateTime.now().millisecondsSinceEpoch}.jpg';
    final ref = FirebaseStorage.instance.ref().child(fileName);
    final uploadTask = await ref.putFile(file);
    final url = await uploadTask.ref.getDownloadURL();
    return url;
  }

  // --- Add Student dialog: choose gallery image OR provide URL. Preview shown.
  void _showAddStudentDialog() {
    final nameController = TextEditingController();
    final classController = TextEditingController();
    final rollController = TextEditingController();
    final sectionController = TextEditingController();
    final urlController = TextEditingController();
    File? pickedLocalFile;
    String? previewNetworkUrl;

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setStateDialog) {
            Widget avatarPreview() {
              if (pickedLocalFile != null) {
                return CircleAvatar(
                  radius: 42,
                  backgroundColor: Color(0xFF5DCCFC),
                  backgroundImage: FileImage(pickedLocalFile!),
                );
              } else if (previewNetworkUrl != null &&
                  previewNetworkUrl!.isNotEmpty) {
                return CircleAvatar(
                  radius: 42,
                  backgroundImage: NetworkImage(previewNetworkUrl!),
                );
              } else {
                return const CircleAvatar(
                  radius: 42,
                  child: Icon(Icons.person, size: 36),
                );
              }
            }

            Future<void> pickFromGallery() async {
              final file = await _pickLocalImage();
              if (file != null) {
                setStateDialog(() {
                  pickedLocalFile = file;
                  // clear url input since local chosen
                  urlController.clear();
                  previewNetworkUrl = null;
                });
              }
            }

            void setNetworkPreview() {
              final url = urlController.text.trim();
              setStateDialog(() {
                previewNetworkUrl = url.isEmpty ? null : url;
                pickedLocalFile = null;
              });
            }

            Future<void> addStudent() async {
              final name = nameController.text.trim();
              final classText = classController.text.trim();
              final rollText = rollController.text.trim();
              final sectionText = sectionController.text.trim();
              String? finalImageUrl;

              if (pickedLocalFile != null) {
                // Upload to Firebase Storage and get URL
                try {
                  finalImageUrl = await _uploadFile(pickedLocalFile!);
                } catch (e) {
                  // show simple error and return (do not close dialog)
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Image upload failed: $e')),
                    );
                  }
                  return;
                }
              } else if (urlController.text.trim().isNotEmpty) {
                finalImageUrl = urlController.text.trim();
              } else {
                finalImageUrl = null;
              }

              // Basic validation
              if (name.isEmpty) {
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Please enter student name')),
                  );
                }
                return;
              }

              // Save student doc
              await studentsRef.add({
                'name': name,
                'class': classText,
                'roll': rollText,
                'section': sectionText,
                'imageUrl': finalImageUrl,
                'createdAt': FieldValue.serverTimestamp(),
              });

              if (context.mounted) Navigator.pop(context);
            }

            return AlertDialog(
              title: const Text('Add Student'),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    GestureDetector(
                      onTap: pickFromGallery,
                      child: avatarPreview(),
                    ),
                    const SizedBox(height: 8),
                    TextButton.icon(
                      onPressed: pickFromGallery,
                      icon: const Icon(Icons.photo_library),
                      label: const Text('Pick from Gallery'),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: urlController,
                      keyboardType: TextInputType.url,
                      decoration: const InputDecoration(
                        labelText: 'Image URL (optional)',
                        hintText: 'https://example.com/photo.jpg',
                      ),
                      onChanged: (_) => setNetworkPreview(),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: nameController,
                      decoration: const InputDecoration(labelText: 'Name'),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: classController,
                      decoration: const InputDecoration(labelText: 'Class'),
                    ),
                    TextField(
                      controller: rollController,
                      decoration: InputDecoration(labelText: 'roll'),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: sectionController,
                      decoration: const InputDecoration(labelText: 'Section'),
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancel'),
                ),
                ElevatedButton(onPressed: addStudent, child: const Text('Add')),
              ],
            );
          },
        );
      },
    );
  }

  // --- Listen to attendance document for a student on the selected date and return bool stream
  Stream<bool> _studentAttendanceStream(String studentId) {
    return attendanceRef
        .doc(dateId)
        .collection('records')
        .doc(studentId)
        .snapshots()
        .map((snap) {
          if (!snap.exists) return false;
          final data = snap.data();
          if (data == null) return false;
          return (data['isPresent'] ?? false) as bool;
        });
  }

  // --- Toggle attendance state
  Future<void> _toggleAttendance(String studentId, bool current) async {
    await attendanceRef.doc(dateId).collection('records').doc(studentId).set({
      'isPresent': !current,
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  // --- Date picker
  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != selectedDate) {
      setState(() => selectedDate = picked);
    }
  }

  // --- Optional: show counts for selected date
  Widget _attendanceSummary(List<QueryDocumentSnapshot> studentsDocs) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6),
      child: Row(
        children: [
          Text(
            'Date: $dateId',
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          const Spacer(),
          Text(
            'Total: ${studentsDocs.length}',
            style: TextStyle(color: Colors.black87),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF5DCCFC),
        title: const Text('Attendance'),
        actions: [
          IconButton(
            color: Color(0xFF5DCCFC),
            onPressed: _pickDate,
            icon: const Icon(Icons.calendar_month, color: Colors.black87),
          ),
        ],
      ),
      /* floatingActionButton: FloatingActionButton(
        onPressed: _showAddStudentDialog,
        child: const Icon(Icons.person_add),
      )*/
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Text(
                  'Selected Date: $dateId',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(width: 12),
                ElevatedButton.icon(
                  onPressed: _pickDate,
                  icon: const Icon(Icons.edit_calendar, color: Colors.black87),
                  label: const Text(
                    'Change Date',
                    style: TextStyle(color: Colors.black87),
                  ),
                ),
              ],
            ),
          ),

          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: studentsRef.orderBy('name').snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError)
                  return const Center(child: Text('Error loading students'));
                if (!snapshot.hasData)
                  return const Center(child: CircularProgressIndicator());

                final docs = snapshot.data!.docs;

                if (docs.isEmpty) {
                  return Center(
                    child: Text(
                      'No students yet.\nTap + to add a student',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                  );
                }

                return Column(
                  children: [
                    _attendanceSummary(docs),
                    Expanded(
                      child: ListView.builder(
                        itemCount: docs.length,
                        itemBuilder: (context, index) {
                          final doc = docs[index];
                          final id = doc.id;
                          final data = doc.data() as Map<String, dynamic>;
                          final name = data['name'] ?? '';
                          final classText = data['class'] ?? '';
                          final rollText = data['roll'] ?? '';
                          final sectionText = data['section'] ?? '';
                          final imageUrl = data['imageUrl'] as String?;

                          return StreamBuilder<bool>(
                            stream: _studentAttendanceStream(id),
                            builder: (context, attSnap) {
                              final isPresent = attSnap.data ?? false;
                              return Card(
                                margin: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 6,
                                ),
                                child: ListTile(
                                  leading: CircleAvatar(
                                    radius: 28,
                                    backgroundColor: Color(0xFF5DCCFC),
                                    backgroundImage:
                                        (imageUrl != null &&
                                            imageUrl.isNotEmpty)
                                        ? NetworkImage(imageUrl)
                                        : null,
                                    child:
                                        (imageUrl == null || imageUrl.isEmpty)
                                        ? const Icon(Icons.person, size: 28)
                                        : null,
                                  ),
                                  title: Text(
                                    name,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black87,
                                    ),
                                  ),
                                  subtitle: Text(
                                    'Class: $classText   |   Section: $sectionText',
                                  ),
                                  trailing: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        isPresent ? 'Present' : 'Absent',
                                        style: TextStyle(
                                          color: isPresent
                                              ? Colors.green
                                              : Colors.red,
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      Switch(
                                        value: isPresent,
                                        onChanged: (_) =>
                                            _toggleAttendance(id, isPresent),
                                      ),
                                    ],
                                  ),
                                  onTap: () {
                                    // Optionally show student detail or quick toggle
                                    _toggleAttendance(id, isPresent);
                                  },
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
