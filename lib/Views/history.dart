import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../Constants/colors.dart';
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
      backgroundColor: AppColors.bg,
      appBar: AppBar(
        title: Text('Transaction History'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                'History',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.bgDark),
              ),
            ),
              SizedBox(height: 20),
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
            Center(
              child: Text(
                'Monthly Savings Transactions',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.bgDark),
              ),
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

                  return Column(
                    children: [
                      ListTile(
                        title: Text(
                          savingText,
                          style: TextStyle(
                              color: Color.fromARGB(255, 225, 255, 0)),
                        ),
                      ),
                        Divider(),
                    ],
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
