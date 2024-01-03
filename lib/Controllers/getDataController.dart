import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dhiwise/Models/formModel.dart'; 

class FirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<FormData>> getFormData() async {
    QuerySnapshot formDataSnapshot =
        await _firestore.collection('formData').get();

    return formDataSnapshot.docs.map((doc) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      return FormData(
        title: data['title'],
        completionDate: data['completionDate'].toDate(),
        recentDateTime: data['recentDateTime'].toDate(),
        monthlySaving: data['monthlySaving'],
        goal: data['goal'], monthlySalary: data['monthlySalary'], id: '',
      );
    }).toList();
  }

  Future<void> deleteFormData(String title) async {
    await _firestore
        .collection('formData')
        .where('title', isEqualTo: title)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        doc.reference.delete();
      });
    });
    // setState(() {}); // Refresh UI after deletion
  }

  dispose() {}
  }
