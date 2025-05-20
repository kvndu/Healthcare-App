import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Healthcare App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  final CalendarFormat _calendarFormat = CalendarFormat.month;
  final DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  int _currentIndex = 0;
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 200),
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.3).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.elasticOut,
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _handleFooterTap(int index) {
    setState(() {
      _currentIndex = index;
    });
    _animationController.reset();
    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue[50],
      body: SafeArea(
        child: Column(
          children: [
            // Main content
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Welcome',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue[800],
                        ),
                      ),
                      SizedBox(height: 20),

                      // Enhanced Search Bar
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 6,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'Search hospitals or doctors',
                            hintStyle: TextStyle(fontWeight: FontWeight.w500),
                            prefixIcon: Icon(Icons.search, color: Colors.blue),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(vertical: 18, horizontal: 20),
                          ),
                        ),
                      ),
                      SizedBox(height: 25),

                      // Calendar with enhanced styling
                      Card(
                        elevation: 6,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: TableCalendar(
                            firstDay: DateTime.utc(2010, 10, 16),
                            lastDay: DateTime.utc(2030, 3, 14),
                            focusedDay: _focusedDay,
                            calendarFormat: _calendarFormat,
                            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                            onDaySelected: (selectedDay, focusedDay) {
                              setState(() => _selectedDay = selectedDay);
                            },
                            headerStyle: HeaderStyle(
                              formatButtonVisible: false,
                              titleCentered: true,
                              titleTextStyle: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue[800],
                              ),
                            ),
                            calendarStyle: CalendarStyle(
                              todayDecoration: BoxDecoration(
                                color: Colors.blue[400],
                                shape: BoxShape.circle,
                              ),
                              selectedDecoration: BoxDecoration(
                                color: Colors.teal[400],
                                shape: BoxShape.circle,
                              ),
                              weekendTextStyle: TextStyle(color: Colors.red[400]),
                              defaultTextStyle: TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 25),

                      // Enhanced Government/Private toggle
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            child: _buildCustomButton(
                              text: 'GOVERNMENT',
                              backgroundColor: Colors.blue[700]!,
                              foregroundColor: Colors.white,
                              icon: Icons.account_balance,
                            ),
                          ),
                          SizedBox(width: 12),
                          Expanded(
                            child: _buildCustomButton(
                              text: 'PRIVATE',
                              backgroundColor: Colors.purple[400]!,
                              foregroundColor: Colors.white,
                              icon: Icons.business,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),

                      // Enhanced Nearby/Specialties toggle
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            child: _buildCustomButton(
                              text: 'NEARBY',
                              backgroundColor: Colors.green[600]!,
                              foregroundColor: Colors.white,
                              icon: Icons.location_on,
                            ),
                          ),
                          SizedBox(width: 12),
                          Expanded(
                            child: _buildCustomButton(
                              text: 'SPECIALTIES',
                              backgroundColor: Colors.orange[600]!,
                              foregroundColor: Colors.white,
                              icon: Icons.medical_services,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 40),

                      // Enhanced Book Appointment button
                      Center(
                        child: _buildCustomButton(
                          text: 'BOOK APPOINTMENT',
                          backgroundColor: Colors.teal[600]!,
                          foregroundColor: Colors.white,
                          icon: Icons.calendar_today,
                          isLarge: true,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Enhanced Animated Footer
            Container(
              padding: EdgeInsets.symmetric(vertical: 14),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10,
                    offset: Offset(0, -2),
                  ),
                ],
                border: Border(top: BorderSide(color: Colors.grey.shade300)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildAnimatedFooterButton(
                    icon: Icons.home,
                    label: 'HOME',
                    index: 0,
                    iconColor: Colors.blue[800]!,
                  ),
                  _buildAnimatedFooterButton(
                    icon: Icons.new_releases,
                    label: 'NEWS',
                    index: 1,
                    iconColor: Colors.purple[600]!,
                  ),
                  _buildAnimatedFooterButton(
                    icon: Icons.emergency,
                    label: 'EMERGENCY',
                    index: 2,
                    iconColor: Colors.red[600]!,
                  ),
                  _buildAnimatedFooterButton(
                    icon: Icons.person,
                    label: 'PROFILE',
                    index: 3,
                    iconColor: Colors.green[600]!,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCustomButton({
    required String text,
    required Color backgroundColor,
    required Color foregroundColor,
    required IconData icon,
    bool isLarge = false,
  }) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        foregroundColor: foregroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        padding: EdgeInsets.symmetric(
          vertical: isLarge ? 18 : 16,
          horizontal: isLarge ? 24 : 12,
        ),
        elevation: 4,
        shadowColor: Colors.black26,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: isLarge ? 22 : 20),
          SizedBox(width: 8),
          Text(
            text,
            style: TextStyle(
              fontSize: isLarge ? 16 : 14,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAnimatedFooterButton({
    required IconData icon,
    required String label,
    required int index,
    required Color iconColor,
  }) {
    final isSelected = _currentIndex == index;
    final color = isSelected ? iconColor : Colors.grey[600];

    return GestureDetector(
      onTap: () => _handleFooterTap(index),
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          final scale = isSelected ? _scaleAnimation.value : 1.0;
          return Transform.scale(
            scale: scale,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: isSelected ? iconColor.withOpacity(0.2) : Colors.transparent,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(icon, color: color, size: 28),
                ),
                SizedBox(height: 4),
                Text(
                  label,
                  style: TextStyle(
                    color: color,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                    letterSpacing: 0.5,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}