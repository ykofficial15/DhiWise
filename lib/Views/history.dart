import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../Models/formModel.dart';

class HistoryScreen extends StatefulWidget {
  final FormData formData;
  final int savedAmount;

  HistoryScreen({required this.formData, required this.savedAmount});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  @override
  Widget build(BuildContext context) {
    DateTime currentDate = DateTime.now();
    DateTime recentDateTime = widget.formData.recentDateTime;

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 0, 2, 42),
      appBar: AppBar(
        title: Text('Transaction History'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  'Goal: ${widget.formData.goal}',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                Text(
                  'Saved Amount: ${widget.savedAmount}',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ],
            ),
            SizedBox(height: 20),
            Text(
              'Monthly Savings:',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 255, 242, 0)),
            ),
            SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: currentDate.difference(recentDateTime).inDays + 1,
                itemBuilder: (context, index) {
                  DateTime dateToAdd =
                      recentDateTime.add(Duration(days: index));
                  int monthlySaving = widget.formData.monthlySaving;

                  String formattedDate =
                      DateFormat('MMM dd, yyyy').format(dateToAdd);
                  String savingText =
                      'On $formattedDate "\$$monthlySaving\" added';

                  return ListTile(
                    title: Text(
                      savingText,
                      style: TextStyle(
                          color: const Color.fromARGB(255, 142, 255, 146)),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
