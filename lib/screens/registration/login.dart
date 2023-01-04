// import 'package:arithmetic/screens/Register/register.dart';
import 'package:first_app_a/screens/registration/register.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class login extends StatefulWidget {
  const login({Key? key}) : super(key: key);

  @override
  State<login> createState() => _login();
}

class _login extends State<login> {
  TextEditingController email = new TextEditingController();
  TextEditingController password = new TextEditingController();
  bool showPassword = false;
  final form = GlobalKey<FormState>();
  final FirebaseAuth _auth= FirebaseAuth.instance;
  Future<void> login() async {
    try{
      final user=(await _auth.signInWithEmailAndPassword(
          email: email.text,
          password: password.text)
      ).user;
      if(user!=null){
        print("Login success");
        Navigator.of(context).pushNamed("/homescreen");
      }
    }catch(e){
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString()))
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blueGrey,
        appBar: AppBar(
          title: Text("Login Page"),
        ),
        body: Form(
            key: form,
            child: Column(
              children: [
                Container(
                  child: Image.asset("assets/image/th.jpg"),
                ),
                Container(
                  margin: EdgeInsets.all(10),
                  child: TextFormField(
                    controller: email,
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return "Email is required";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.email),
                      hintText: "Please Enter Your Email",
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(10),
                  child: TextFormField(
                      controller: password,
                      obscureText: !showPassword,
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.password),
                          hintText: "Please Enter Your Password",
                          suffixIcon: showPassword
                              ? InkWell(
                                  onTap: () {
                                    setState(() {});
                                  },
                                  child: Icon(Icons.panorama_fish_eye))
                              : InkWell(
                                  onTap: () {
                                    setState(() {
                                      showPassword = !showPassword;
                                    });
                                  },
                                  child: Icon(Icons.remove_red_eye)))),
                ),
                // Container(),
                ElevatedButton(
                  onPressed: () {
                    if (form.currentState!.validate()) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Login validation success"),
                        ),
                      );
                    }
                  },
                  child: Text("Login"),
                ),
                ElevatedButton(
                    onPressed: () {
                      // Navigator.of(context).push(
                      //   MaterialPageRoute(builder: (BuildContext context) => RegisterScreen(),
                      //   ));
                      Navigator.of(context).pushNamed("/register");
                    },
                    child: Text(" Go to Registration")),
              ],
            )));
  }
}
