import 'package:flutter/material.dart';

class Loginscreen extends StatefulWidget {
  const Loginscreen({super.key});

  @override
  State<Loginscreen> createState() => _LoginscreenState();
}

class _LoginscreenState extends State<Loginscreen> {
  bool isVisible = false;

  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.white60,
      appBar: AppBar(centerTitle: true, title: Text("Login")),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(28.0),
          child: Center(
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.center,
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // SizedBox(height: 30,),
                CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.blue.shade100,
                  child: Icon(
                    Icons.cloud,
                    color: Colors.blue.shade600,
                    size: 50,
                  ),
                ),
                SizedBox(height: 30),
                Text(
                  "Welcome Back",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 35),
                ),
                SizedBox(height: 20),
                Text(
                  "Login to check your local weather and \n    stay updated with local forecasts",
                  style: TextStyle(color: Colors.grey.shade600, fontSize: 17),
                ),
                SizedBox(height: 30),
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Email",
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        controller: emailController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          labelText: "Enter your email",
                          labelStyle: TextStyle(color: Colors.grey.shade600),
                        ),
                      ),

                      SizedBox(height: 20),

                      Text(
                        "Password",
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        obscureText: !isVisible,
                        controller: passController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          labelText: "Enter your password",
                          labelStyle: TextStyle(color: Colors.grey.shade600),
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
                      ),
                      SizedBox(height: 40,),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 16),
                          backgroundColor: Colors.blue,
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadiusGeometry.circular(10)
                          )
                        ),
                        onPressed: (){

                      }, child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Login",style: TextStyle(
                            color: Colors.white,
                            fontSize: 18
                          ),),
                          SizedBox(width: 5,),
                          Icon(Icons.login,color: Colors.white,)
                        ],
                      )),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Divider(height: 10,),
                          Text("OR"),
                          Divider()
                        ],
                      )
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
