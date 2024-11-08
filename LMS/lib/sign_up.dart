import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: VerifyStudentNumber(),
    );
  }
}

class VerifyStudentNumber extends StatefulWidget {
  @override
  _VerifyStudentNumber createState() => _VerifyStudentNumber();
}

class _VerifyStudentNumber extends State<VerifyStudentNumber> {
  TextEditingController studentNumberController = TextEditingController();
  String studentNumber = '';
  bool isValid = false;
  String errorMessage = '';

  // Simulated API call to check if student number exists (mocked for now)
  Future<bool> checkStudentNumberFromDatabase(String studentNumber) async {
    await Future.delayed(Duration(seconds: 2)); // Simulating delay
    List<String> enrolledStudentNumbers = ['12-34567', '34-56789', '45-67890'];
    return enrolledStudentNumbers.contains(studentNumber);
  }

  void checkStudentNumber() async {
    setState(() {
      studentNumber = studentNumberController.text;
      errorMessage = ''; // Clear previous error message
    });

    bool valid = await checkStudentNumberFromDatabase(studentNumber);

    setState(() {
      isValid = valid;
      errorMessage = valid ? '' : 'Student number not found or not enrolled.';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFD9DBDA),
      appBar: AppBar(
        backgroundColor: Color(0xFF4AC73C),
        elevation: 0,
        title: buildHeader(context),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Container(
            width: 550, // Adjusted container width for the "Verify" section
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Centering the Title "Verify your Student Number"
                Center(
                  child: Text(
                    'Verify your Student Number',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(height: 20),

                // "Enter your Student Number" label above the input field
                Text(
                  'Enter your Student Number:',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),

                // Student Number Input Field inside a Container with a border
                Container(
                  width: double
                      .infinity, // Make the container width full within the 550px
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey), // Border for input
                  ),
                  child: TextField(
                    controller: studentNumberController,
                    decoration: InputDecoration(
                      hintText: 'Student Number',
                      errorText: errorMessage.isNotEmpty ? errorMessage : null,
                      border: InputBorder.none,
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    ),
                    keyboardType: TextInputType.text,
                  ),
                ),
                SizedBox(height: 20),

                // Check button aligned to the right with padding adjustment
                Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton(
                    onPressed: checkStudentNumber,
                    child: Text(
                      'Check',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF4AC73C),
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    ),
                  ),
                ),
                SizedBox(height: 5),

                // Display validation result
                if (studentNumber.isNotEmpty)
                  Text(
                    isValid ? 'Student Number Valid' : 'Student Number Invalid',
                    style: TextStyle(
                        color: isValid ? Colors.green : Colors.red,
                        fontSize: 16),
                  ),
                SizedBox(height: 15),

                // Center the "Next" button and prevent overflow
                Center(
                  child: ElevatedButton(
                    onPressed: isValid
                        ? () {
                            // Navigate directly to the next page after validation
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => RegisterAccountPage(),
                              ),
                            );
                          }
                        : null, // Disable if invalid
                    child: Text(
                      'Next',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Header Widget with University Information
  Widget buildHeader(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double fontSize = screenWidth < 600 ? 13.0 : 15.0;
    double subtitleFontSize = screenWidth < 600 ? 10.0 : 13.0;
    double avatarSize = screenWidth < 600 ? 20.0 : 25.0;
    double spacing = screenWidth < 600 ? 8.0 : 12.0;

    return Container(
      height: 120,
      color: const Color(0xFFD9DBDA),
      padding: EdgeInsets.all(8),
      child: Row(
        children: [
          // Image icon for logo
          Image.asset(
            'assets/images/plsp.jpg', // Path to your image
            height: avatarSize,
            width: avatarSize,
          ),
          SizedBox(width: spacing),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Pamantasan ng Lungsod ng San Pablo',
                  style: TextStyle(
                    fontSize: fontSize,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4.0),
                Text(
                  'Brgy. San Jose, San Pablo City',
                  style: TextStyle(
                    fontSize: subtitleFontSize,
                    color: Colors.black,
                  ),
                ),
                Text(
                  'Tel No: (049) 536-7380',
                  style: TextStyle(
                    fontSize: subtitleFontSize,
                    color: Colors.black,
                  ),
                ),
                Text(
                  'Email Address: plspofficial@plsp.edu.ph',
                  style: TextStyle(
                    fontSize: subtitleFontSize,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Register Account Page
class RegisterAccountPage extends StatefulWidget {
  @override
  _RegisterAccountPageState createState() => _RegisterAccountPageState();
}

class _RegisterAccountPageState extends State<RegisterAccountPage> {
  TextEditingController studentNumberController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  bool isPasswordMatching() {
    return passwordController.text == confirmPasswordController.text;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFD9DBDA),
      appBar: AppBar(
        backgroundColor: Color(0xFF4AC73C),
        elevation: 0,
        title: buildHeader(context),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Container(
            width: 550, // Set container width to 550
            padding: EdgeInsets.all(16),
            height: 650, // Increased height by 100 units
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Center Title "Register Your Account"
                Center(
                  child: Text(
                    'Register Your Account',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(height: 20),

                // Add Student Number Field outside the form container
                Text(
                  'Enter your Student Number:',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                TextFormField(
                  controller: studentNumberController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your student number';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),

                // Last Name Input outside form container
                Text(
                  'Enter your Last Name:',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                TextFormField(
                  controller: lastNameController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your last name';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),

                // Email Input outside form container
                Text(
                  'Enter your Email:',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email address';
                    }
                    if (!RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$')
                        .hasMatch(value)) {
                      return 'Please enter a valid email address';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),

                // Password Input outside form container
                Text(
                  'Create your Password:',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                TextFormField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please create a password';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),

                // Confirm Password Input outside form container
                Text(
                  'Re-type your Password:',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                TextFormField(
                  controller: confirmPasswordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please re-enter your password';
                    }
                    if (!isPasswordMatching()) {
                      return 'Passwords do not match';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),

                // Submit Button
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // Process registration
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Processing Data')),
                        );
                      }
                    },
                    child: Text('Submit'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildHeader(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double fontSize = screenWidth < 600 ? 13.0 : 15.0;
    double subtitleFontSize = screenWidth < 600 ? 10.0 : 13.0;
    double avatarSize = screenWidth < 600 ? 20.0 : 25.0;
    double spacing = screenWidth < 600 ? 8.0 : 12.0;

    return Container(
      height: 120,
      color: const Color(0xFFD9DBDA),
      padding: EdgeInsets.all(8),
      child: Row(
        children: [
          // Image icon for logo
          Image.asset(
            'assets/images/plsp.jpg', // Path to your image
            height: avatarSize,
            width: avatarSize,
          ),
          SizedBox(width: spacing),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Pamantasan ng Lungsod ng San Pablo',
                  style: TextStyle(
                    fontSize: fontSize,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4.0),
                Text(
                  'Brgy. San Jose, San Pablo City',
                  style: TextStyle(
                    fontSize: subtitleFontSize,
                    color: Colors.black,
                  ),
                ),
                Text(
                  'Tel No: (049) 536-7380',
                  style: TextStyle(
                    fontSize: subtitleFontSize,
                    color: Colors.black,
                  ),
                ),
                Text(
                  'Email Address: plspofficial@plsp.edu.ph',
                  style: TextStyle(
                    fontSize: subtitleFontSize,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
