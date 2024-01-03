import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import '../Models/formModel.dart';

class FormDataProvider with ChangeNotifier {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> saveFormData(FormData formData) async {
    try {
      CollectionReference formDataCollection =
          firestore.collection('formData');

      await formDataCollection.add({
        'title': formData.title,
        'goal': formData.goal, // Assuming goal is an int
        'completionDate': Timestamp.fromDate(formData.completionDate), // Convert to Timestamp
        'monthlySaving': formData.monthlySaving, // Assuming monthlySaving is an int
        'monthlySalary': formData.monthlySalary, // Assuming monthlySalary is an int
        'recentDateTime': Timestamp.fromDate(formData.recentDateTime), // Assuming recentDateTime is DateTime
      });

      // Notify listeners inside the method
      notifyListeners();
    } catch (e) {
      print('Error saving data: $e');
    }
  }
}
