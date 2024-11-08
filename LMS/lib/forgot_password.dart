import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Forgot Password App',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: ForgotPasswordPage(), // Main Entry Point
    );
  }
}

class ForgotPasswordPage extends StatefulWidget {
  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _studentNumberController =
      TextEditingController();
  final TextEditingController _otpController = TextEditingController();

  String? _otpErrorMessage;
  bool _isButtonDisabled = false; // To manage button state
  int _secondsRemaining = 5; // Timer count
  Timer? _timer; // Timer reference

  String? _userEmail;
  bool _isOTPMode = false;
  bool _isStudentMode = false; // Flag for Student Number input mode

  // Function to simulate sending OTP
  void _sendOTP() {
    if (!_isButtonDisabled) {
      setState(() {
        // Determine if email or student number was entered
        _userEmail = _isStudentMode
            ? _studentNumberController.text.trim()
            : _emailController.text.trim();
        _isOTPMode = true; // Show OTP input fields
        _secondsRemaining = 120; // Reset the timer
        _isButtonDisabled = true; // Disable the button during the countdown
      });

      // Simulate sending the OTP (replace with actual logic)
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("OTP has been sent to ${_userEmail}.")),
      );

      // Start the countdown timer
      _startTimer();
    }
  }

  // Function to start a countdown timer for OTP resend
  void _startTimer() {
    _timer?.cancel(); // Cancel any existing timer
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_secondsRemaining > 0) {
          _secondsRemaining--;
        } else {
          _isButtonDisabled = false; // Enable the button to send OTP again
          _timer?.cancel(); // Stop the timer
        }
      });
    });
  }

  // Function to verify OTP and navigate to password reset page
  void _verifyOTP() {
    String otp = _otpController.text.trim();

    if (otp.isEmpty) {
      setState(() {
        _otpErrorMessage = "Please enter the OTP.";
      });
      return;
    }

    // Simulate OTP verification (replace with actual verification logic)
    if (otp == "123456") {
      // OTP verified, now navigate to the password reset page
      setState(() {
        _isOTPMode = false; // Hide OTP fields
      });

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ResetPasswordPage()),
      );
    } else {
      setState(() {
        _otpErrorMessage = "Invalid OTP. Please try again.";
      });
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  // Add header to the top of the page
  Widget buildHeader(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double fontSize = screenWidth < 600 ? 13.0 : 15.0;
    double subtitleFontSize = screenWidth < 600 ? 10.0 : 13.0;
    double avatarSize = 10.0; // Fixed width and height for the image
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

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text('Forgot Password'),
        backgroundColor: Color(0xFF4AC73C),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Add header at the top of the page
              buildHeader(context),

              SizedBox(height: 20), // Space between header and form content

              Container(
                width: screenWidth * 0.8,
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Input for email or student number
                    Text(
                      _isStudentMode
                          ? 'Enter your Student Number:'
                          : 'Enter your email address:',
                      style: TextStyle(fontSize: 16, color: Colors.black),
                    ),
                    SizedBox(height: 8),
                    TextField(
                      controller: _isStudentMode
                          ? _studentNumberController
                          : _emailController,
                      decoration: InputDecoration(
                        hintText:
                            _isStudentMode ? 'Student Number' : 'Email Address',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _isButtonDisabled ? null : _sendOTP,
                      child: Text('Send OTP'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF4AC73C),
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    // Toggle between email and student number mode
                    TextButton(
                      onPressed: () {
                        setState(() {
                          _isStudentMode = !_isStudentMode;
                        });
                      },
                      child: Text(
                        _isStudentMode
                            ? "Use Email instead of Student Number"
                            : "Use Student Number instead of Email",
                        style: TextStyle(color: Colors.blue),
                      ),
                    ),
                    if (_isOTPMode) ...[
                      // OTP Input Field (for OTP verification)
                      Text(
                        'Enter the OTP sent to ${_userEmail}:',
                        style: TextStyle(fontSize: 16, color: Colors.black),
                      ),
                      SizedBox(height: 8),
                      TextField(
                        controller: _otpController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: 'Enter OTP',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          errorText: _otpErrorMessage,
                        ),
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: _verifyOTP,
                        child: Text('Submit'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF4AC73C),
                          foregroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ],
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

class ResetPasswordPage extends StatefulWidget {
  @override
  _ResetPasswordPageState createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  String? _passwordErrorMessage;

  // Function to handle password reset
  void _resetPassword() {
    String password = _passwordController.text.trim();
    String confirmPassword = _confirmPasswordController.text.trim();

    if (password.isEmpty || confirmPassword.isEmpty) {
      setState(() {
        _passwordErrorMessage =
            "Please enter both password and confirmation password.";
      });
      return;
    }

    if (password != confirmPassword) {
      setState(() {
        _passwordErrorMessage = "Passwords do not match.";
      });
      return;
    }

    // Simulate password reset (replace with actual logic)
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Password has been reset successfully!")),
    );

    // Optionally navigate to login or home screen
    Navigator.pop(context); // Close the Reset Password screen
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reset Password'),
        backgroundColor: Color(0xFF4AC73C),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.8,
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Enter New Password:',
                  style: TextStyle(fontSize: 16, color: Colors.black),
                ),
                SizedBox(height: 8),
                TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: 'New Password',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'Confirm Password:',
                  style: TextStyle(fontSize: 16, color: Colors.black),
                ),
                SizedBox(height: 8),
                TextField(
                  controller: _confirmPasswordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: 'Confirm Password',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _resetPassword,
                  child: Text('Change Password'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF4AC73C),
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
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
}
