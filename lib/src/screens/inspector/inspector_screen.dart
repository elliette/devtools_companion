import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Meal {
  const Meal({
    required this.name,
    required this.description,
    required this.ingredients,
  });

  final String name;
  final String description;
  final List<String> ingredients;
}

const meals = [
  Meal(
    name: 'Oatmeal',
    description: 'A healthy and hearty breakfast.',
    ingredients: ['Rolled oats', 'Milk', 'Honey', 'Berries'],
  ),
  Meal(
    name: 'Salad',
    description: 'A light and refreshing lunch.',
    ingredients: ['Lettuce', 'Tomato', 'Cucumber', 'Dressing'],
  ),
  Meal(
    name: 'Spaghetti Carbonara',
    description: 'A classic Italian pasta dish.',
    ingredients: ['Spaghetti', 'Eggs', 'Pancetta', 'Parmesan cheese', 'Black pepper'],
  ),
];

enum CalendarView { month, week }

class InspectorScreen extends StatefulWidget {
  const InspectorScreen({super.key});

  @override
  State<InspectorScreen> createState() => _InspectorScreenState();
}

class _InspectorScreenState extends State<InspectorScreen> {
  DateTime? _selectedDate;
  Meal _selectedMeal = meals[2]; // Default to Spaghetti
  CalendarView _calendarView = CalendarView.month;

  void _onDateSelected(DateTime date) {
    setState(() {
      _selectedDate = date;
    });
  }

  void _showCalendar() {
    setState(() {
      _selectedDate = null;
    });
  }

  void _onMealSelected(Meal meal) {
    setState(() {
      _selectedMeal = meal;
    });
  }

  void _onCalendarViewChanged(CalendarView view) {
    setState(() {
      _calendarView = view;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meal Planner'),
      ),
      body: Column(
        children: [
          Expanded(
            child: _selectedDate == null
                ? CalendarWidget(
                    onDateSelected: _onDateSelected,
                    initialView: _calendarView,
                    onViewChanged: _onCalendarViewChanged,
                  )
                : DailyMealPlan(
                    date: _selectedDate!,
                    onTap: _showCalendar,
                    onMealSelected: _onMealSelected,
                  ),
          ),
          Expanded(
            child: RecipeWidget(meal: _selectedMeal),
          ),
        ],
      ),
    );
  }
}

class DailyMealPlan extends StatelessWidget {
  const DailyMealPlan({
    super.key,
    required this.date,
    required this.onTap,
    required this.onMealSelected,
  });

  final DateTime date;
  final VoidCallback onTap;
  final ValueChanged<Meal> onMealSelected;

  @override
  Widget build(BuildContext context) {
    final dayName = DateFormat('EEEE').format(date);
    return Stack(
      children: [
        Positioned(
          top: 0,
          left: 0,
          child: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: onTap,
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Text(
                '${date.month}/${date.day}/${date.year} - $dayName',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ),
            const SizedBox(height: 16),
            InkWell(
              onTap: () => onMealSelected(meals[0]),
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('Breakfast: Oatmeal'),
              ),
            ),
            InkWell(
              onTap: () => onMealSelected(meals[1]),
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('Lunch: Salad'),
              ),
            ),
            InkWell(
              onTap: () => onMealSelected(meals[2]),
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('Dinner: Spaghetti Carbonara'),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class CalendarWidget extends StatefulWidget {
  const CalendarWidget({
    super.key,
    required this.onDateSelected,
    required this.initialView,
    required this.onViewChanged,
  });

  final ValueChanged<DateTime> onDateSelected;
  final CalendarView initialView;
  final ValueChanged<CalendarView> onViewChanged;

  @override
  State<CalendarWidget> createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget> {
  late CalendarView _view;

  @override
  void initState() {
    super.initState();
    _view = widget.initialView;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ToggleButtons(
          isSelected: [_view == CalendarView.month, _view == CalendarView.week],
          onPressed: (index) {
            final newView = index == 0 ? CalendarView.month : CalendarView.week;
            setState(() {
              _view = newView;
            });
            widget.onViewChanged(newView);
          },
          children: const [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text('Month'),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text('Week'),
            ),
          ],
        ),
        Expanded(
          child: _view == CalendarView.month
              ? MonthViewWidget(onDateSelected: widget.onDateSelected)
              : WeekViewWidget(onDateSelected: widget.onDateSelected),
        ),
      ],
    );
  }
}

class MonthViewWidget extends StatefulWidget {
  const MonthViewWidget({super.key, required this.onDateSelected});

  final ValueChanged<DateTime> onDateSelected;

  @override
  State<MonthViewWidget> createState() => _MonthViewWidgetState();
}

class _MonthViewWidgetState extends State<MonthViewWidget> {
  final _pageController = PageController(initialPage: DateTime.now().month - 1);
  late String _monthName;
  late int _currentMonth;

  @override
  void initState() {
    super.initState();
    _currentMonth = DateTime.now().month;
    _monthName = DateFormat('MMMM').format(DateTime(2025, _currentMonth));
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
                _currentMonth = index + 1;
                _monthName = DateFormat('MMMM').format(DateTime(2025, _currentMonth));
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
                final date = DateTime(2025, month, i);
                calendarItems.add(
                  InkWell(
                    onTap: () => widget.onDateSelected(date),
                    child: Center(
                      child: Text('$i'),
                    ),
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

class WeekViewWidget extends StatefulWidget {
  const WeekViewWidget({super.key, required this.onDateSelected});

  final ValueChanged<DateTime> onDateSelected;

  @override
  State<WeekViewWidget> createState() => _WeekViewWidgetState();
}

class _WeekViewWidgetState extends State<WeekViewWidget> {
  late final PageController _pageController;
  late DateTime _currentWeekStart;

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    final firstDayOf2025 = DateTime(2025);
    final firstMondayOfYear =
        firstDayOf2025.subtract(Duration(days: firstDayOf2025.weekday - 1));

    int initialPage = 0;
    if (now.year == 2025) {
      initialPage = (now.difference(firstMondayOfYear).inDays / 7).floor();
    }
    if (initialPage < 0) initialPage = 0;
    if (initialPage > 52) initialPage = 52;

    _pageController = PageController(initialPage: initialPage);
    _currentWeekStart = firstMondayOfYear.add(Duration(days: initialPage * 7));
  }

  @override
  Widget build(BuildContext context) {
    final weekEnd = _currentWeekStart.add(const Duration(days: 6));
    final formatter = DateFormat('MMM d');
    final headerText = '${formatter.format(_currentWeekStart)} - ${formatter.format(weekEnd)}';

    return Column(
      children: [
        Text(headerText),
        const SizedBox(height: 16),
        Expanded(
          child: PageView.builder(
            controller: _pageController,
            itemCount: 53, // A year can span 53 weeks
            onPageChanged: (index) {
              final firstDayOfYear = DateTime(2025);
              final firstMondayOfYear =
                  firstDayOfYear.subtract(Duration(days: firstDayOfYear.weekday - 1));
              setState(() {
                _currentWeekStart = firstMondayOfYear.add(Duration(days: index * 7));
              });
            },
            itemBuilder: (context, index) {
              final firstDayOfYear = DateTime(2025);
              final firstMondayOfYear =
                  firstDayOfYear.subtract(Duration(days: firstDayOfYear.weekday - 1));
              final firstDayOfWeek = firstMondayOfYear.add(Duration(days: index * 7));

              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(7, (dayIndex) {
                  final date = firstDayOfWeek.add(Duration(days: dayIndex));
                  return InkWell(
                    onTap: () => widget.onDateSelected(date),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(DateFormat('E').format(date)), // Day of week (e.g., Mon)
                        Text('${date.day}'),
                      ],
                    ),
                  );
                }),
              );
            },
          ),
        ),
      ],
    );
  }
}

class RecipeWidget extends StatelessWidget {
  const RecipeWidget({super.key, required this.meal});

  final Meal meal;

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
              meal.name,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Text(meal.description),
            const SizedBox(height: 16),
            const Text(
              'Ingredients:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            for (final ingredient in meal.ingredients) Text('- $ingredient'),
          ],
        ),
      ),
    );
  }
}
