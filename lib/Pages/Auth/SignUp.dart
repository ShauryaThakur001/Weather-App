import 'package:flutter/material.dart';
import 'package:weatherrapp/Pages/Auth/LoginScreen.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool isVisible = false;
  bool isVisible2 = false;

  final _formKey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPassController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEAF2FB),
      appBar: AppBar(
        backgroundColor: Color(0xFFEAF2FB),
        centerTitle: true,
        title: Text("Sign Up"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsetsGeometry.symmetric(horizontal: 20),
          child: Center(
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // SizedBox(height: 10,),
                Icon(Icons.cloud, size: 60, color: Colors.blue.shade600),
                SizedBox(height: 8),
                Text(
                  "Join WeatherWise",
                  style: TextStyle(fontWeight: FontWeight.w900, fontSize: 34),
                ),
                SizedBox(height: 7),
                Text(
                  "Track the storm, stay informed",
                  style: TextStyle(
                    fontWeight: FontWeight.w100,
                    fontSize: 18,
                    color: Colors.grey.shade600,
                  ),
                ),
                SizedBox(height: 30),
                Container(
                  height: 550,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Full Name",
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 7),
                          TextFormField(
                            controller: nameController,
                            decoration: InputDecoration(
                              fillColor: Color(0xFFEAF2FB),
                              filled: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              labelText: "Enter your Full Name",
                              labelStyle: TextStyle(
                                color: Colors.grey.shade600,
                              ),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Enter Your Full Name ";
                              }
                              return null;
                            },
                          ),

                          SizedBox(height: 20),
                          Text(
                            "Email",
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 7),
                          TextFormField(
                            controller: emailController,
                            decoration: InputDecoration(
                              fillColor: Color(0xFFEAF2FB),
                              filled: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              labelText: "Enter your email",
                              labelStyle: TextStyle(
                                color: Colors.grey.shade600,
                              ),
                            ),
                            validator: (value) {
                              if (value!.isEmpty ||
                                  !value.contains('@gmail.com')) {
                                return "Enter Your Email Correctly";
                              }
                              return null;
                            },
                          ),

                          SizedBox(height: 20),

                          Text(
                            "Password",
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 7),
                          TextFormField(
                            obscureText: !isVisible,
                            controller: passwordController,
                            decoration: InputDecoration(
                              fillColor: Color(0xFFEAF2FB),
                              filled: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              labelText: "Enter your password",
                              labelStyle: TextStyle(
                                color: Colors.grey.shade600,
                              ),
                              suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    isVisible = !isVisible;
                                  });
                                },
                                icon: isVisible
                                    ? Icon(
                                        Icons.visibility_off,
                                        color: Colors.grey.shade600,
                                      )
                                    : Icon(
                                        Icons.visibility,
                                        color: Colors.grey.shade600,
                                      ),
                              ),
                            ),
                            validator: (value) {
                              if (value!.isEmpty || value.length < 5) {
                                return "Password Length should be Greater than 5";
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 20),
                          Text(
                            "Confirm Password",
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 7),
                          TextFormField(
                            obscureText: !isVisible2,
                            controller: confirmPassController,
                            decoration: InputDecoration(
                              fillColor: Color(0xFFEAF2FB),
                              filled: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              labelText: "Enter your Password again",
                              labelStyle: TextStyle(
                                color: Colors.grey.shade600,
                              ),
                              suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    isVisible2 = !isVisible2;
                                  });
                                },
                                icon: isVisible2
                                    ? Icon(
                                        Icons.visibility_off,
                                        color: Colors.grey.shade600,
                                      )
                                    : Icon(
                                        Icons.visibility,
                                        color: Colors.grey.shade600,
                                      ),
                              ),
                            ),
                            validator: (value) {
                              if (value!.isEmpty ||
                                  value != passwordController.text) {
                                return "Password Mismatched";
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 30),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(vertical: 16),
                              backgroundColor: Colors.blue,
                              elevation: 5,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadiusGeometry.circular(10),
                              ),
                            ),
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                // Firebase Check the email etc...
                              }
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Create Account",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
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
                SizedBox(height: 15),
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => Loginscreen()),
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Already have an Account? ",
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 15,
                        ),
                      ),
                      Text(
                        "Login",
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 15,
                          fontWeight: FontWeight.w800,
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
}
