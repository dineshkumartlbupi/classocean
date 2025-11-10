import 'package:flutter/material.dart';

class FeesScreen extends StatefulWidget {
  const FeesScreen({super.key});

  @override
  State<FeesScreen> createState() => _FeesScreenState();
}

class _FeesScreenState extends State<FeesScreen> {
  // Sample data
  final List<Map<String, String>> feeRecords = [
    {
      'name': 'Alice',
      'fatherName': 'Robert',
      'class': '10',
      'section': 'A',
      'amount': '2000',
      'type': 'Student',
    },
    {
      'name': 'Mr. John',
      'fatherName': '-',
      'class': '-',
      'section': '-',
      'amount': '5000',
      'type': 'Teacher',
    },
  ];

  // Controllers for input fields
  final nameController = TextEditingController();
  final fatherNameController = TextEditingController();
  final classController = TextEditingController();
  final sectionController = TextEditingController();
  final amountController = TextEditingController();

  String selectedType = "Student"; // Student or Teacher

  @override
  void dispose() {
    nameController.dispose();
    fatherNameController.dispose();
    classController.dispose();
    sectionController.dispose();
    amountController.dispose();
    super.dispose();
  }

  void _addRecord() {
    if (nameController.text.isEmpty || amountController.text.isEmpty) return;

    setState(() {
      feeRecords.add({
        'name': nameController.text,
        'fatherName': fatherNameController.text.isEmpty
            ? '-'
            : fatherNameController.text,
        'class': selectedType == 'Teacher' ? '-' : classController.text,
        'section': selectedType == 'Teacher' ? '-' : sectionController.text,
        'amount': amountController.text,
        'type': selectedType,
      });
    });

    Navigator.pop(context); // close dialog
    _clearFields();
  }

  void _clearFields() {
    nameController.clear();
    fatherNameController.clear();
    classController.clear();
    sectionController.clear();
    amountController.clear();
  }

  void _showAddDialog() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Add Fee Record"),
        content: SingleChildScrollView(
          child: Column(
            children: [
              DropdownButtonFormField<String>(
                value: selectedType,
                decoration: const InputDecoration(labelText: "Type"),
                items: const [
                  DropdownMenuItem(value: "Student", child: Text("Student")),
                  DropdownMenuItem(value: "Teacher", child: Text("Teacher")),
                ],
                onChanged: (value) {
                  setState(() => selectedType = value!);
                },
              ),
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: "Name"),
              ),
              if (selectedType == "Student")
                TextField(
                  controller: fatherNameController,
                  decoration:
                  const InputDecoration(labelText: "Father's Name"),
                ),
              if (selectedType == "Student")
                TextField(
                  controller: classController,
                  decoration: const InputDecoration(labelText: "Class"),
                ),
              if (selectedType == "Student")
                TextField(
                  controller: sectionController,
                  decoration: const InputDecoration(labelText: "Section"),
                ),
              TextField(
                controller: amountController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: "Fee Amount"),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            child: const Text("Cancel"),
            onPressed: () => Navigator.pop(context),
          ),
          ElevatedButton(
            child: const Text("Add"),
            onPressed: _addRecord,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Fees Management"),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _showAddDialog,
          ),
        ],
      ),
      body: feeRecords.isEmpty
          ? const Center(child: Text("No fee records added yet"))
          : ListView.builder(
        itemCount: feeRecords.length,
        itemBuilder: (context, index) {
          final record = feeRecords[index];
          return Card(
            margin:
            const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            elevation: 3,
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: record['type'] == 'Student'
                    ? Colors.blue
                    : Colors.green,
                child: Icon(
                  record['type'] == 'Student'
                      ? Icons.person
                      : Icons.school,
                  color: Colors.white,
                ),
              ),
              title: Text(
                "${record['name']} (${record['type']})",
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (record['type'] == 'Student')
                    Text("Father: ${record['fatherName']}"),
                  if (record['type'] == 'Student')
                    Text("Class: ${record['class']} | Section: ${record['section']}"),
                  Text("💰 Amount: ₹${record['amount']}"),
                ],
              ),
              trailing: IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: () {
                  setState(() {
                    feeRecords.removeAt(index);
                  });
                },
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _showAddDialog,
        icon: const Icon(Icons.add),
        label: const Text("Add Record"),
      ),
    );
  }
}

