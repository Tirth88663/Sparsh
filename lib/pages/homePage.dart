import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // late DateTime _selectedDate;

  @override
  void initState() {
    super.initState();
    // _resetSelectedDate();
  }

  // void _resetSelectedDate() {
  //   _selectedDate = DateTime.now();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: const Text("Sparsh"),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // CalendarTimeline(
            //   showYears: true,
            //   initialDate: _selectedDate,
            //   firstDate: DateTime.now(),
            //   lastDate: DateTime.now().add(const Duration(days: 365 * 4)),
            //   onDateSelected: (date) => setState(() => _selectedDate = date),
            //   leftMargin: 20,
            //   monthColor: Theme.of(context).colorScheme.onBackground,
            //   dayColor: Theme.of(context).colorScheme.onBackground,
            //   dayNameColor: Theme.of(context).colorScheme.secondary,
            //   activeDayColor: Theme.of(context).colorScheme.secondary,
            //   activeBackgroundDayColor: Theme.of(context).colorScheme.tertiary,
            //   dotsColor: const Color(0xFF333A47),
            //   selectableDayPredicate: (date) => date.day != 23,
            //   locale: 'en',
            // ),
          ],
        ),
      ),
    );
  }
}
