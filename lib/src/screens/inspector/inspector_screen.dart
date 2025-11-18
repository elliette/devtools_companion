import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class InspectorScreen extends StatelessWidget {
  const InspectorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meal Planner'),
      ),
      body: const Column(
        children: [
          Expanded(
            child: CalendarWidget(),
          ),
          Expanded(
            child: RecipeWidget(),
          ),
        ],
      ),
    );
  }
}

class CalendarWidget extends StatefulWidget {
  const CalendarWidget({super.key});

  @override
  State<CalendarWidget> createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget> {
  final _pageController = PageController(initialPage: DateTime.now().month - 1);
  late String _monthName;

  @override
  void initState() {
    super.initState();
    _monthName = DateFormat('MMMM').format(DateTime(2025, DateTime.now().month));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('$_monthName 2025'),
        const SizedBox(height: 16),
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text('Mon'),
            Text('Tue'),
            Text('Wed'),
            Text('Thu'),
            Text('Fri'),
            Text('Sat'),
            Text('Sun'),
          ],
        ),
        Expanded(
          child: PageView.builder(
            controller: _pageController,
            itemCount: 12,
            onPageChanged: (index) {
              setState(() {
                _monthName = DateFormat('MMMM').format(DateTime(2025, index + 1));
              });
            },
            itemBuilder: (context, index) {
              final month = index + 1;
              final daysInMonth = DateTime(2025, month + 1, 0).day;
              final firstDayOfMonth = DateTime(2025, month, 1);
              final weekdayOfFirstDay = firstDayOfMonth.weekday; // Monday is 1, Sunday is 7

              final List<Widget> calendarItems = [];
              // Add empty containers for the days of the week before the first day of the month.
              for (int i = 1; i < weekdayOfFirstDay; i++) {
                calendarItems.add(Container());
              }

              // Add the days of the month.
              for (int i = 1; i <= daysInMonth; i++) {
                calendarItems.add(
                  Center(
                    child: Text('$i'),
                  ),
                );
              }

              return GridView.count(
                crossAxisCount: 7,
                children: calendarItems,
              );
            },
          ),
        ),
      ],
    );
  }
}

class RecipeWidget extends StatelessWidget {
  const RecipeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Spaghetti Carbonara',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            const Text(
              'A classic Italian pasta dish.',
            ),
            const SizedBox(height: 16),
            const Text(
              'Ingredients:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text('- Spaghetti'),
            const Text('- Eggs'),
            const Text('- Pancetta'),
            const Text('- Parmesan cheese'),
            const Text('- Black pepper'),
          ],
        ),
      ),
    );
  }
}
