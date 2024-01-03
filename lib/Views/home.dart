import 'package:dhiwise/Views/login.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../Constants/exception.dart';
import '../Controllers/formController.dart';
import 'package:dhiwise/Models/formModel.dart';

import '../Controllers/persistentLogin.dart';

class Home extends StatefulWidget {
  const Home({Key? key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _goalController = TextEditingController();
  final TextEditingController _monthlySalaryController =
      TextEditingController();
  final TextEditingController _completionDateController =
      TextEditingController();
  final TextEditingController _monthlySavingController =
      TextEditingController();
  final TextEditingController _recentDateTime = TextEditingController();
  final DateFormat _firestoreDateFormat = DateFormat('yyyy-MM-dd');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      backgroundColor: Color.fromARGB(255, 0, 2, 42),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 40,
            ),
            Text(
              'What is your goal?',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    TextFormField(
                      controller: _titleController,
                      decoration: InputDecoration(
                        labelText: 'Title',
                        labelStyle: TextStyle(color: Colors.grey),
                        border: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                      ),
                      style: TextStyle(color: Colors.white),
                      cursorColor: Colors.white,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter a title';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _goalController,
                      decoration: InputDecoration(
                        labelText: 'Goal',
                        labelStyle: TextStyle(color: Colors.grey),
                        border: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                      ),
                      style: TextStyle(color: Colors.white),
                      cursorColor: Colors.white,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter a goal';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _completionDateController,
                      decoration: InputDecoration(
                        labelText: 'Goal Completion Date',
                        labelStyle: TextStyle(color: Colors.grey),
                        border: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                      ),
                      style: TextStyle(color: Colors.white),
                      cursorColor: Colors.white,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter a completion date';
                        }
                        return null;
                      },
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2101),
                        );
                        if (pickedDate != null) {
                          setState(() {
                            _completionDateController.text =
                                _firestoreDateFormat.format(pickedDate);
                          });
                        }
                      },
                    ),
                    TextFormField(
                      controller: _monthlySavingController,
                      decoration: InputDecoration(
                        labelText: 'Monthly Projection Saving',
                        labelStyle: TextStyle(color: Colors.grey),
                        border: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                      ),
                      style: TextStyle(color: Colors.white),
                      cursorColor: Colors.white,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter monthly saving';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      controller: _monthlySalaryController,
                      decoration: InputDecoration(
                        labelText: 'Monthly Salary',
                        labelStyle: TextStyle(color: Colors.grey),
                        border: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                      ),
                      style: TextStyle(color: Colors.white),
                      cursorColor: Colors.white,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter monthly salary';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      controller: _recentDateTime,
                      decoration: InputDecoration(
                        labelText: 'Current Date',
                        labelStyle: TextStyle(color: Colors.grey),
                        border: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                      ),
                      style: TextStyle(color: Colors.white),
                      cursorColor: Colors.white,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter today\'s date';
                        }
                        return null;
                      },
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2101),
                        );
                        if (pickedDate != null) {
                          setState(() {
                            _recentDateTime.text =
                                _firestoreDateFormat.format(pickedDate);
                          });
                        }
                      },
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          FormData formData = FormData(
                            title: _titleController.text,
                            goal: int.parse(_goalController.text),
                            completionDate:
                                DateTime.parse(_completionDateController.text),
                            monthlySaving:
                                int.parse(_monthlySavingController.text),
                            monthlySalary:
                                int.parse(_monthlySalaryController.text),
                            recentDateTime:
                                DateTime.parse(_recentDateTime.text),
                            id: '',
                          );
                          FormDataProvider formDataProvider =
                              Provider.of<FormDataProvider>(context,
                                  listen: false);
                          formDataProvider.saveFormData(formData);
                          SuccessToast.show(message: "Data Saved Successfully");
                          _formKey.currentState!.reset();
                        }
                      },
                      child: Text(
                        'Submit',
                        style: TextStyle(
                            color: const Color.fromARGB(255, 0, 50, 91)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
