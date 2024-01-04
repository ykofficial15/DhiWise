import 'package:cloud_firestore/cloud_firestore.dart';

class FormData {
  String title;
  int goal;
  DateTime completionDate; 
  int monthlySaving;
  int monthlySalary;
  DateTime recentDateTime;
  String id;

  FormData({
    required this.title,
    required this.goal,
    required this.completionDate,
    required this.monthlySaving,
    required this.monthlySalary,
    required this.recentDateTime,
    required this.id,
  });
}
