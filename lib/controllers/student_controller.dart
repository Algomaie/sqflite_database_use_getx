import 'package:get/get.dart';
import '../db_helper.dart';
import '../models/student.dart';

class StudentController extends GetxController {
  final DatabaseHelper _dbHelper = DatabaseHelper();
  var students = <Student>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchStudents();
  }

  Future<void> addStudent(Student student) async {
    await _dbHelper.insertStudent(student.toMap());
    fetchStudents();
  }

  Future<void> fetchStudents() async {
    final studentsMap = await _dbHelper.getStudents();
    students.value = studentsMap.map((studentMap) {
      return Student(
        id: studentMap['id'],
        name: studentMap['name'],
        age: studentMap['age'],
        course: studentMap['course'],
      );
    }).toList();
  }

  Future<void> updateStudent(Student student) async {
    await _dbHelper.updateStudent(student.toMap());
    fetchStudents();
  }

  Future<void> deleteStudent(int id) async {
    await _dbHelper.deleteStudent(id);
    fetchStudents();
  }
}
