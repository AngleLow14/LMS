import 'dart:async';
import 'package:flutter/material.dart';

class VerificationPage extends StatefulWidget {
  final String userEmail;

  VerificationPage({required this.userEmail});

  @override
  _VerificationPageState createState() => _VerificationPageState();
}

class _VerificationPageState extends State<VerificationPage> {
  final TextEditingController _otpController = TextEditingController();
  String? _otpErrorMessage;

  bool _isButtonDisabled = false; // To manage button state
  int _secondsRemaining = 120; // Timer count
  Timer? _timer; // Timer reference

  // Function to verify OTP (dummy logic for now)
  void _verifyOTP() {
    String otp = _otpController.text.trim();

    if (otp.isEmpty) {
      setState(() {
        _otpErrorMessage = "Please enter the OTP.";
      });
    } else {
      // Simulate OTP verification (replace with actual verification logic)
      if (otp == "123456") {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("OTP Verified Successfully!")),
        );
      } else {
        setState(() {
          _otpErrorMessage = "Invalid OTP. Please try again.";
        });
      }
    }
  }

  // Function to resend OTP (dummy logic for now)
  void _resendOTP() {
    // Start the countdown when OTP is sent
    setState(() {
      _isButtonDisabled = true; // Disable the button
      _secondsRemaining = 120; // Reset timer
    });

    // Simulate sending the OTP (replace with actual logic)
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("OTP has been resent to ${widget.userEmail}.")),
    );

    // Start a 120-second countdown
    _startTimer();
  }

  // Start a countdown timer that updates every second
  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_secondsRemaining > 0) {
          _secondsRemaining--;
        } else {
          _isButtonDisabled =
              false; // Enable the button once 120 seconds have passed
          _timer?.cancel(); // Stop the timer
        }
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel(); // Cancel the timer when the widget is disposed
    super.dispose();
  }

  // Function to build the header with dynamic sizing based on screen width
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

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text('Email Verification'),
        backgroundColor: Color(0xFF4AC73C), // AppBar color
      ),
      body: Column(
        children: [
          // The header section
          buildHeader(context),

          // Main verification content
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Center(
              child: Container(
                width: screenWidth *
                    0.8, // Make the container width responsive (80% of screen width)
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Container Title
                    Text(
                      'Verify Your Account',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 10),

                    // Subtitle
                    Text(
                      'Type the code that is sent to your account.',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black54,
                      ),
                    ),
                    SizedBox(height: 20),

                    // OTP Input Field (No label text, just a blank field)
                    Text(
                      'Enter the Code:',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 8),
                    TextField(
                      controller: _otpController,
                      keyboardType: TextInputType.number,
                      onChanged: (text) {
                        // Reset the error message when user starts typing
                        setState(() {
                          _otpErrorMessage = null;
                        });
                      },
                      decoration: InputDecoration(
                        hintText: 'Enter OTP',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        errorText: _otpErrorMessage,
                      ),
                    ),
                    SizedBox(height: 20),

                    // Send OTP Button (Border and color)
                    ElevatedButton(
                      onPressed: _isButtonDisabled ? null : _resendOTP,
                      child: _isButtonDisabled
                          ? Text(
                              'Resend OTP in $_secondsRemaining seconds',
                              style: TextStyle(color: Color(0xFF4AC73C)),
                            )
                          : Text(
                              'Send OTP',
                              style: TextStyle(color: Color(0xFF4AC73C)),
                            ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            Colors.white, // Button background color
                        foregroundColor:
                            Color(0xFF4AC73C), // Text color (when active)
                        side: BorderSide(
                            color: Color(0xFF4AC73C)), // Border color
                        padding: EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),

                    // Submit Button (Primary color and text color)
                    ElevatedButton(
                      onPressed: _verifyOTP,
                      child: Text('Submit'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            Color(0xFF4AC73C), // Button background color
                        foregroundColor: Colors.white, // Text color
                        padding: EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),

                    // Resend OTP Text
                    Center(
                      child: TextButton(
                        onPressed: _resendOTP,
                        child: Text(
                          "Didn't receive any code? Resend",
                          style: TextStyle(
                            color: Color(0xFF4AC73C), // Text color
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
