import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/schedulling_provider.dart';

class SettingPage extends StatelessWidget {
  static const String account = 'Setting';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 75,
        elevation: 0.0,
        title: Text(account),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Colors.white, Colors.yellow],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight
              )
          ),
        ),
      ),
      body: ListTile(
        title: Text('Daily Reminder'),
        trailing: Consumer<SchedulingProvider>(
          builder: (context, schedule, child) {
            return Switch.adaptive(value: schedule.isScheduled, onChanged: (value) async {
              schedule.scheduledNews(value);
            });
          },
        ),
      ),
    );
  }
}
