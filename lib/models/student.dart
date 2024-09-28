class Student {
  final int? id;
  final String name;
  final int age;
  final String course;

  Student(
      {this.id, required this.name, required this.age, required this.course});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'age': age,
      'course': course,
    };
  }
}
