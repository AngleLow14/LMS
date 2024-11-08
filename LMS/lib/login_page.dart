import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // Controllers for text fields
  final TextEditingController studentNumberController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // Error messages for login fields
  String? studentNumberError;
  String? passwordError;

  // Sample data for validation
  final String validStudentNumber = '12-34567'; // Example valid student number
  final String validPassword = 'password'; // Example valid password

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double fontSize = screenWidth < 600 ? 12.0 : 15.0;

    return Scaffold(
      backgroundColor: Color(0xFFD9DBDA),
      appBar: AppBar(
        backgroundColor: Color(0xFF4AC73C),
        elevation: 0,
        title: buildHeader(context),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                SizedBox(height: 20),
                Container(
                  width: screenWidth < 600
                      ? screenWidth * 0.8
                      : 550, // Responsive width
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Login or Sign Up',
                        style: TextStyle(
                          fontSize: fontSize,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 20),

                      // Student Number field
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Student Number',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(height: 8),
                      TextField(
                        controller: studentNumberController,
                        decoration: InputDecoration(
                          hintText: 'Enter Student Number',
                          errorText:
                              studentNumberError, // Specific error message
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 16, vertical: 10),
                        ),
                        keyboardType: TextInputType.number,
                      ),
                      SizedBox(height: 16),

                      // Password field
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Password',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(height: 8),
                      TextField(
                        controller: passwordController,
                        decoration: InputDecoration(
                          hintText: 'Enter Password',
                          errorText: passwordError, // Specific error message
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 16, vertical: 10),
                        ),
                        obscureText: true,
                      ),
                      SizedBox(height: 20),

                      // Submit button
                      ElevatedButton(
                        onPressed: _validateLogin,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12.0),
                          child: Text(
                            'Submit',
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),

                      GestureDetector(
                        onTap: () {
                          // Navigate to Sign Up page
                        },
                        child: Text(
                          "Didn't have an Account? Sign Up",
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      GestureDetector(
                        onTap: () {
                          // Navigate to Forgot Password page
                        },
                        child: Text(
                          'Forgot Password',
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _validateLogin() {
    setState(() {
      studentNumberError = null; // Reset the error message for student number
      passwordError = null; // Reset the error message for password

      String studentNumber = studentNumberController.text;
      String password = passwordController.text;

      // Combine validation logic into one
      if (studentNumber != validStudentNumber) {
        studentNumberError = 'Incorrect student number';
      }
      if (password != validPassword) {
        passwordError = 'Incorrect password';
      }

      // Proceed with the login if no errors
      if (studentNumberError == null && passwordError == null) {
        print('Login successful!');
      }
    });
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
