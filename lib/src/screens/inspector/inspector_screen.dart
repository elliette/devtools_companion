import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import '../../shared/ui/theme.dart';

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
    name: 'Overflowing Oatmeal',
    description: 'A healthy and hearty breakfast.',
    ingredients: [
      'Rolled oats',
      'Milk',
      'Honey',
      'Berries',
      'A very long line of text that will definitely overflow the screen and cause a render overflow error.',
    ],
  ),
  Meal(
    name: 'Salad',
    description: 'A light and refreshing lunch.',
    ingredients: ['Lettuce', 'Tomato', 'Cucumber', 'Dressing'],
  ),
  Meal(
    name: 'Spaghetti Carbonara',
    description: 'A classic Italian pasta dish.',
    ingredients: [
      'Spaghetti',
      'Eggs',
      'Pancetta',
      'Parmesan cheese',
      'Black pepper',
    ],
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
  Meal? _selectedMeal;
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

  void _onMealSelected(Meal? meal) {
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
      appBar: AppBar(title: const Text('Meal Planner')),
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
                    onTap: () {
                      _showCalendar();
                      _onMealSelected(null);
                    },
                    onMealSelected: _onMealSelected,
                  ),
          ),
          Expanded(child: RecipeWidget(meal: _selectedMeal)),
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
          top: noPadding,
          left: noPadding,
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
            const SizedBox(height: largeSpacing),
            Table(
              columnWidths: const {
                0: IntrinsicColumnWidth(),
                1: IntrinsicColumnWidth(),
              },
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              children: [
                TableRow(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(right: denseSpacing),
                      child: Text('Breakfast:'),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: ShadButton.ghost(
                        onPressed: () => onMealSelected(meals[0]),
                        child: Text(meals[0].name),
                      ),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(right: denseSpacing),
                      child: Text('Lunch:'),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: ShadButton.ghost(
                        onPressed: () => onMealSelected(meals[1]),
                        child: Text(meals[1].name),
                      ),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(right: denseSpacing),
                      child: Text('Dinner:'),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: ShadButton.ghost(
                        onPressed: () => onMealSelected(meals[2]),
                        child: Text(meals[2].name),
                      ),
                    ),
                  ],
                ),
              ],
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
    return ShadTabs<CalendarView>(
      value: _view,
      tabs: [
        ShadTab(
          value: CalendarView.month,
          content: MonthViewWidget(onDateSelected: widget.onDateSelected),
          child: const Text('Month'),
        ),
        ShadTab(
          value: CalendarView.week,
          content: WeekViewWidget(onDateSelected: widget.onDateSelected),
          child: const Text('Week'),
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
  late DateTime _currentMonth;

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    _currentMonth = DateTime(now.year, now.month);
  }

  void _previousMonth() {
    setState(() {
      _currentMonth = DateTime(_currentMonth.year, _currentMonth.month - 1);
    });
  }

  void _nextMonth() {
    setState(() {
      _currentMonth = DateTime(_currentMonth.year, _currentMonth.month + 1);
    });
  }

  @override
  Widget build(BuildContext context) {
    final monthName = DateFormat('MMMM yyyy').format(_currentMonth);
    final daysInMonth = DateTime(
      _currentMonth.year,
      _currentMonth.month + 1,
      0,
    ).day;
    final firstDayOfMonth = DateTime(_currentMonth.year, _currentMonth.month);
    final weekdayOfFirstDay =
        firstDayOfMonth.weekday; // Monday is 1, Sunday is 7

    final List<Widget> calendarItems = [];
    for (int i = 1; i < weekdayOfFirstDay; i++) {
      calendarItems.add(Container());
    }

    for (int i = 1; i <= daysInMonth; i++) {
      final date = DateTime(_currentMonth.year, _currentMonth.month, i);
      calendarItems.add(
        InkWell(
          onTap: () => widget.onDateSelected(date),
          child: Center(child: Text('$i')),
        ),
      );
    }

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: const Icon(Icons.chevron_left),
              onPressed: _previousMonth,
            ),
            Text(monthName),
            IconButton(
              icon: const Icon(Icons.chevron_right),
              onPressed: _nextMonth,
            ),
          ],
        ),
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
        GridView.count(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          crossAxisCount: 7,
          childAspectRatio: 1.5,
          children: calendarItems,
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
  late DateTime _currentWeekStart;

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    // Start the week on the Monday of the current week.
    _currentWeekStart = now.subtract(Duration(days: now.weekday - 1));
  }

  void _previousWeek() {
    setState(() {
      _currentWeekStart = _currentWeekStart.subtract(const Duration(days: 7));
    });
  }

  void _nextWeek() {
    setState(() {
      _currentWeekStart = _currentWeekStart.add(const Duration(days: 7));
    });
  }

  @override
  Widget build(BuildContext context) {
    final weekEnd = _currentWeekStart.add(const Duration(days: 6));
    final formatter = DateFormat('MMM d');
    final headerText =
        '${formatter.format(_currentWeekStart)} - ${formatter.format(weekEnd)}';

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: const Icon(Icons.chevron_left),
              onPressed: _previousWeek,
            ),
            Text(headerText),
            IconButton(
              icon: const Icon(Icons.chevron_right),
              onPressed: _nextWeek,
            ),
          ],
        ),
        const SizedBox(height: denseSpacing),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(7, (dayIndex) {
            final date = _currentWeekStart.add(Duration(days: dayIndex));
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
        ),
      ],
    );
  }
}

class RecipeWidget extends StatelessWidget {
  const RecipeWidget({super.key, required this.meal});

  final Meal? meal;

  @override
  Widget build(BuildContext context) {
    return ShadCard(
      child: Padding(
        padding: const EdgeInsets.all(largeSpacing),
        child: meal == null
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Select a meal to view its recipe.',
                      style: ShadTheme.of(context).textTheme.h4,
                    ),
                    const SizedBox(height: largeSpacing),
                    Image.asset('assets/images/habanero.jpg', height: 200),
                  ],
                ),
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    meal!.name,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: denseSpacing),
                  Text(meal!.description),
                  const SizedBox(height: largeSpacing),
                  const Text(
                    'Ingredients:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: denseSpacing),
                  for (final ingredient in meal!.ingredients)
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [const Text('- '), Text(ingredient)],
                    ),
                ],
              ),
      ),
    );
  }
}
