import 'package:dhiwise/Views/history.dart';
import 'package:flutter/material.dart';
import 'package:dhiwise/Models/formModel.dart';
import 'package:intl/intl.dart';

import '../Constants/colors.dart';

class DetailScreen extends StatefulWidget {
  final FormData formData;

  DetailScreen({required this.formData});

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _progressAnimation;
  late int savedAmount;

  @override
  void initState() {
    super.initState();
    savedAmount = _calculateSavedAmount();
    _calculateProgress();
  }

  int _calculateSavedAmount() {
    DateTime currentDate = DateTime.now();
    DateTime recentDateTime = widget.formData.recentDateTime;
    DateTime completionDate = widget.formData.completionDate;
    int monthlySaving = widget.formData.monthlySaving;

    if (currentDate.isBefore(completionDate)) {
      int savedDays = currentDate.difference(recentDateTime).inDays;
      return monthlySaving * savedDays + monthlySaving;
    }
    return widget.formData
        .goal; // If currentDate is after recentDateTime, return the goal amount
  }

  void _calculateProgress() {
    double savedAmount = _calculateSavedAmount().toDouble();
    double goal = widget.formData.goal.toDouble();

    double progressValue = (savedAmount / goal) * 100;

    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );

    _progressAnimation = Tween<double>(
      begin: 0,
      end: progressValue.isNaN ? 0 : progressValue,
    ).animate(_animationController);

    _progressAnimation.addListener(() {
      setState(() {});
    });

    _animationController.forward(from: 0);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final String report =
        (widget.formData.goal <= savedAmount) ? "Completed" : "You Saved";
    final String progression = (_progressAnimation.value > 100)
        ? "Progress: 100%"
        : "Progress: ${(_progressAnimation.value).toInt()}%";
    return Scaffold(
      backgroundColor: AppColors.bg,
      appBar: AppBar(
        title: Text(
          'DHIWISE',
          style: TextStyle(fontSize: 24), // Bigger font size for the title
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: AppColors.bg, // Set background color to blue
          // padding: EdgeInsets.all(20), // Add padding for content spacing
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: 50,
              ),
              Text(
                widget.formData.title,
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              SizedBox(
                height: 20,
              ),
              Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    height: 200,
                    width: 200,
                    child: CircularProgressIndicator(
                      value: _progressAnimation.value / 100,
                      semanticsLabel: 'Saving progress',
                      strokeWidth: 10,
                      backgroundColor: Colors.white,
                      valueColor: AlwaysStoppedAnimation<Color>(
                          AppColors.bgDark),
                    ),
                  ),
                  Column(
                    children: [
                      Icon(
                        Icons.home,
                        color: Colors.white,
                        size: 80,
                      ),
                      Text(
                        '\$$savedAmount',
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      Text(
                        report,
                        style: TextStyle(fontSize: 12, color: Colors.white),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 20),
              Text(
                progression,
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              SizedBox(height: 20),
              Container(
                margin: EdgeInsets.fromLTRB(80, 0, 80, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Goal',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                        Text(
                          '\$${widget.formData.goal}',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    Divider(
                      color: Colors.white,
                      thickness: 1,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        'Completion by ${DateFormat('dd MMM yyyy').format(widget.formData.completionDate)}',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Container(
                width: MediaQuery.sizeOf(context).width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: AppColors.bgDark,
                ),
                padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                margin: EdgeInsets.fromLTRB(60, 0, 60, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Need more savings: \$${widget.formData.goal - savedAmount}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      'Monthly saving projection: \$${widget.formData.monthlySaving}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Contribution',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: AppColors.bgDark,
                              fontSize: 15),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HistoryScreen(
                                  formData: widget.formData,
                                  savedAmount: savedAmount,
                                ),
                              ),
                            );
                          },
                          child: Text(
                            'History',
                            style: TextStyle(
                                color: AppColors.bgDark,
                                fontWeight: FontWeight.normal),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Text('Monthly Salary',
                              style: TextStyle(color: Color(0xFF002747))),
                        ),
                        Expanded(
                          child: Text('Days Completed',
                              style: TextStyle(color: Color(0xFF002747))),
                        ),
                        Expanded(
                          child: Text('Starting Date',
                              style: TextStyle(color: Color(0xFF002747))),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: LinearProgressIndicator(
                            value:
                                0.5, // Placeholder value for monthly salary progress
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.blue),
                            backgroundColor: Colors.transparent,
                          ),
                        ),
                        Expanded(
                          child: LinearProgressIndicator(
                            value:
                                0.6, // Placeholder value for days from recent progress
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.yellow),
                            backgroundColor: Colors.transparent,
                          ),
                        ),
                        Expanded(
                          child: LinearProgressIndicator(
                            value:
                                0.8, // Placeholder value for saved amount progress
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.teal),
                            backgroundColor: Colors.transparent,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            '\$${widget.formData.monthlySaving}',
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            '${DateTime.now().difference(widget.formData.recentDateTime).inDays + 1}',
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            '${DateFormat('dd MMM yyyy').format(widget.formData.recentDateTime)}',
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
