import 'package:flutter/material.dart';
import 'animate_gradient.dart'; // Import the animated gradient
import 'dart:async'; // For Timer

void main() {
  runApp(FitnessApp());
}

class FitnessApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/wallpaper1.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            SizedBox(height: 100), // Height for the title area
            Padding(
              padding: const EdgeInsets.only(top: 20.0, bottom: 20.0), // Adjust padding here
              child: Column(
                children: [
                  Text(
                    'myWorkout Tracker', // Title text
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: const Color.fromARGB(255, 98, 88, 88), // Adjust text color to contrast the background
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    'Track your workouts and progress.', // Subtitle text
                    style: TextStyle(
                      fontSize: 18,
                      color: const Color.fromARGB(255, 98, 88, 88), // Adjust text color for subtitle
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            SizedBox(height: 500), // Add space to lower the buttons
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    FitnessButton(label: 'myWorkouts', page: WorkoutTrackerPage()), // Button 1
                    FitnessButton(label: 'myCooldown', page: CooldownPage()), // Button 2
                    FitnessButton(label: 'myProgress', page: ProgressTrackerPage()), // Button 3
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    FitnessButton(label: 'myCalories', page: CaloriesTrackerPage()), // Button 4
                    FitnessButton(label: 'myMeals', page: MealPlannerPage()), // Button 5
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class FitnessButton extends StatelessWidget {
  final String label;
  final Widget page;

  FitnessButton({required this.label, required this.page});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => page),
        );
      },
      child: Text(label),
    );
  }
}

// Workout tracker page

class WorkoutTrackerPage extends StatefulWidget {
  @override
  _WorkoutTrackerPageState createState() => _WorkoutTrackerPageState();
}

class _WorkoutTrackerPageState extends State<WorkoutTrackerPage> {
  final List<Map<String, String>> _workouts = [];

  final _dateController = TextEditingController();
  final _activityController = TextEditingController();
  final _caloriesController = TextEditingController();
  final _timeController = TextEditingController();
  final _distanceController = TextEditingController();
  final _setsController = TextEditingController();
  final _repsController = TextEditingController();
  final _weightController = TextEditingController();

  @override
  void dispose() {
    _dateController.dispose();
    _activityController.dispose();
    _caloriesController.dispose();
    _timeController.dispose();
    _distanceController.dispose();
    _setsController.dispose();
    _repsController.dispose();
    _weightController.dispose();
    super.dispose();
  }

  void _addWorkout() {
    setState(() {
      _workouts.add({
        'Date': _dateController.text,
        'Activity': _activityController.text,
        'Calories': _caloriesController.text,
        'Time': _timeController.text,
        'Distance': _distanceController.text,
        'Sets': _setsController.text,
        'Reps': _repsController.text,
        'Weight': _weightController.text,
      });
    });

    _dateController.clear();
    _activityController.clear();
    _caloriesController.clear();
    _timeController.clear();
    _distanceController.clear();
    _setsController.clear();
    _repsController.clear();
    _weightController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('images/workouttracker2.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Main content with AppBar and workout tracker
          Column(
            children: [
              AppBar(
                title: Text(
                  'Workout Tracker',
                  style: TextStyle(
                    fontWeight: FontWeight.bold, // Bold title
                  ),
                ),
                backgroundColor: Colors.transparent,
                elevation: 0,
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        // Row with GIFs
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'images/gym2.gif',
                              width: 150,
                              height: 150,
                              fit: BoxFit.cover,
                            ),
                            SizedBox(width: 10),
                            Image.asset(
                              'images/running.gif',
                              width: 150,
                              height: 150,
                              fit: BoxFit.cover,
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        Text(
                          'Track your workouts here!',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 20),
                        _buildInputForm(),
                        SizedBox(height: 20),
                        _buildWorkoutTable(),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInputForm() {
    return Column(
      children: [
        _buildTextField(_dateController, 'Date (e.g., 2024-10-27)'),
        _buildTextField(_activityController, 'Activity'),
        _buildTextField(_caloriesController, 'Calories'),
        _buildTextField(_timeController, 'Time (e.g., 30 mins)'),
        _buildTextField(_distanceController, 'Distance (e.g., 5 km)'),
        _buildTextField(_setsController, 'Sets'),
        _buildTextField(_repsController, 'Reps'),
        _buildTextField(_weightController, 'Weight (e.g., 135 lbs)'),
        SizedBox(height: 10),
        ElevatedButton(
          onPressed: _addWorkout,
          child: Text('Add Workout'),
        ),
      ],
    );
  }

  Widget _buildTextField(TextEditingController controller, String label) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0),
    child: TextField(
      controller: controller,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderSide: BorderSide(width: 2.0, color: Colors.black),
        ),
        labelText: label,
        labelStyle: TextStyle(
          fontWeight: FontWeight.bold, // Bolden label text
        ),
      ),
      style: TextStyle(
        fontWeight: FontWeight.bold, // Bolden input text
      ),
      enableSuggestions: false, // Disables suggestions and toolbar
      autocorrect: false, // Disables autocorrection
    ),
  );
}


  Widget _buildWorkoutTable() {
    return Scrollbar(
      thumbVisibility: true,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columns: [
            DataColumn(label: Text('Date', style: TextStyle(fontWeight: FontWeight.bold))),
            DataColumn(label: Text('Activity', style: TextStyle(fontWeight: FontWeight.bold))),
            DataColumn(label: Text('Calories', style: TextStyle(fontWeight: FontWeight.bold))),
            DataColumn(label: Text('Time', style: TextStyle(fontWeight: FontWeight.bold))),
            DataColumn(label: Text('Distance', style: TextStyle(fontWeight: FontWeight.bold))),
            DataColumn(label: Text('Sets', style: TextStyle(fontWeight: FontWeight.bold))),
            DataColumn(label: Text('Reps', style: TextStyle(fontWeight: FontWeight.bold))),
            DataColumn(label: Text('Weight', style: TextStyle(fontWeight: FontWeight.bold))),
          ],
          rows: _workouts.map((workout) {
            return DataRow(cells: [
              DataCell(Text(workout['Date'] ?? '', style: TextStyle(fontWeight: FontWeight.bold))),
              DataCell(Text(workout['Activity'] ?? '', style: TextStyle(fontWeight: FontWeight.bold))),
              DataCell(Text(workout['Calories'] ?? '', style: TextStyle(fontWeight: FontWeight.bold))),
              DataCell(Text(workout['Time'] ?? '', style: TextStyle(fontWeight: FontWeight.bold))),
              DataCell(Text(workout['Distance'] ?? '', style: TextStyle(fontWeight: FontWeight.bold))),
              DataCell(Text(workout['Sets'] ?? '', style: TextStyle(fontWeight: FontWeight.bold))),
              DataCell(Text(workout['Reps'] ?? '', style: TextStyle(fontWeight: FontWeight.bold))),
              DataCell(Text(workout['Weight'] ?? '', style: TextStyle(fontWeight: FontWeight.bold))),
            ]);
          }).toList(),
        ),
      ),
    );
  }
}



// Cooldown page with breathing exercise
class CooldownPage extends StatefulWidget {
  @override
  _CooldownPageState createState() => _CooldownPageState();
}

class _CooldownPageState extends State<CooldownPage> {
  int count = 3; // Initial countdown value for inhale
  bool isInhale = true; // To track if it's inhale or exhale
  bool hasStarted = false; // To check if countdown started
  bool isPaused = false; // To track if countdown is paused
  Timer? timer;

  void startCooldown() {
    timer?.cancel(); // Cancel any previous timer if active
    setState(() {
      hasStarted = true; // Set the start state to true when button is pressed
      isPaused = false; // Ensure it's not in paused state
    });
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (isInhale && count > 0) {
          count--; // Decrease inhale count
        } else if (isInhale && count == 0) {
          isInhale = false; // Switch to exhale
          count = 10; // Reset for exhale countdown
        } else if (!isInhale && count > 1) {
          count--; // Decrease exhale count
        } else if (!isInhale && count == 1) {
          count = 0; // Stop countdown and show "Well Done!"
          timer.cancel();
        }
      });
    });
  }

  void pauseCooldown() {
    timer?.cancel(); // Pause the timer
    setState(() {
      isPaused = true; // Indicate that the countdown is paused
    });
  }

  void resetCooldown() {
    timer?.cancel(); // Cancel any active timer
    setState(() {
      count = 3; // Reset count to 3 for inhale
      isInhale = true; // Reset to inhale phase
      hasStarted = false; // Indicate that it is not started yet
      isPaused = false; // Indicate that it is not paused
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimateGradient(
        primaryColors: [Colors.blue, const Color.fromARGB(255, 39, 176, 60)],
        secondaryColors: [const Color.fromARGB(255, 48, 176, 208), const Color.fromARGB(255, 164, 151, 193)],
        duration: Duration(seconds: 4),
        child: Stack(
          children: [
            Positioned(
              top: 20,
              left: 10,
              child: IconButton(
                icon: Icon(Icons.arrow_back, color: Colors.white, size: 30),
                onPressed: () {
                  Navigator.pop(context); // Navigate back to HomePage
                },
              ),
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 80), // Adjust height to move title up closer to app bar
                  Text(
                    'myCooldown', // Title text
                    style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  SizedBox(height: 10), // Reduce space below the title
                  Text(
                    'Press start to begin cooldown breathing exercise.', // Subtitle text
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                  SizedBox(height: 40),
                  if (hasStarted)
                    Text(
                      isInhale ? 'Inhale' : 'Exhale', // Display "Inhale" or "Exhale" depending on phase
                      style: TextStyle(fontSize: 32, color: Colors.white),
                    ),
                  SizedBox(height: 20),
                  if (hasStarted)
                    Text(
                      count == 0 && !isInhale
                          ? 'Well Done!' // Show "Well Done!" only at the end of exhale
                          : '$count', // Show countdown
                      style: TextStyle(fontSize: 48, color: Colors.white),
                    ),
                  SizedBox(height: 40),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: hasStarted && !isPaused ? pauseCooldown : startCooldown,
                        child: Text(hasStarted && !isPaused ? 'Pause' : 'Start'),
                      ),
                      SizedBox(width: 10),
                      ElevatedButton(
                        onPressed: resetCooldown,
                        child: Text('Reset'),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Text(
                      'This breathing exercise is the perfect tool to calm your body, slow your heart rate, and reduce stress after a vigorous workout. Simply breathe in for 3 seconds then exhale slowly for 10 seconds!',
                      style: TextStyle(fontSize: 17, color: Colors.white), // Text color set to white to match gradient
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    timer?.cancel(); // Ensure to cancel the timer when the widget is disposed
    super.dispose();
  }
}

// Progress tracker page
class ProgressTrackerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Progress Tracker'),
      ),
      body: Center(
        child: Text('Track your progress over time here!'),
      ),
    );
  }
}

// Calories tracker page
class CaloriesTrackerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calories Tracker'),
      ),
      body: Center(
        child: Text('Track your calories burned here!'),
      ),
    );
  }
}

// Meal planner page
class MealPlannerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Meal Planner'),
      ),
      body: Center(
        child: Text('Plan your meals here!'),
      ),
    );
  }
}
