import 'package:dhiwise/Constants/exception.dart';
import 'package:dhiwise/Constants/indicator.dart';
import 'package:dhiwise/Views/detailScreen.dart';
import 'package:dhiwise/Views/login.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dhiwise/Models/formModel.dart';
import 'package:provider/provider.dart';
import '../Controllers/getDataController.dart';
import '../Controllers/persistentLogin.dart';

class Updates extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var firebaseService = Provider.of<FirebaseService>(context, listen: false);

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 0, 2, 42),
      appBar: AppBar(
        title: Text('DHIWISE'),
        actions: [
          IconButton(
              onPressed: () {
                final authProvider =
                    Provider.of<AuthProvider>(context, listen: false);
                authProvider.logout();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => Login()),
                );
              },
              icon: Icon(Icons.logout)),
        ],
      ),
      body: FutureBuilder<List<FormData>>(
        future: firebaseService.getFormData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: Indicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No data available.'));
          } else {
            return Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Your Financial Goals',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      FormData formData = snapshot.data![index];
                      return Card(
                        child: ListTile(
                          title: Text(formData.title),
                          subtitle: Text('Goal: ${formData.goal.toString()}'),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    DetailScreen(formData: formData),
                              ),
                            );
                          },
                          trailing: IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () {
                              firebaseService.deleteFormData(formData.title);
                              SuccessToast.show(
                                  message: "Goal Deleted Successfully");
                            },
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
