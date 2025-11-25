class StudentModel {
  String id;
  String name;
  String className;
  String section;
  String rollNumber;
  String phoneNumber;
  String fatherName;
  String? imageUrl;

  StudentModel({
    required this.id,
    required this.name,
    required this.className,
    required this.section,
    required this.rollNumber,
    required this.phoneNumber,
    required this.fatherName,
    this.imageUrl,
  });

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "name": name,
      "className": className,
      "section": section,
      "rollNumber": rollNumber,
      "phoneNumber": phoneNumber,
      "fatherName": fatherName,
      "imageUrl": imageUrl,
    };
  }

  factory StudentModel.fromMap(Map<String, dynamic> map) {
    return StudentModel(
        id: map["id"],
        name: map["name"],
        className: map["className"],
        section: map["section"],
        rollNumber: map["rollNumber"],
        phoneNumber: map["phoneNumber"],
        fatherName: map["fatherName"],
        imageUrl: map["imageUrl"],
        );
    }
}