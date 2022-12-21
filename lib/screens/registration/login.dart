import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController email = new TextEditingController();
  TextEditingController password = new TextEditingController();
  bool hidePassword = true;
  final form = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> login() async {
    try{
      final user = (await _auth.signInWithEmailAndPassword(
          email: email.text,
          password: password.text)
      ).user;
      if(user!=null){
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                backgroundColor: Colors.green,
                content: Text("Login Success"))
        );

        Navigator.of(context).pushReplacementNamed("/home");
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
      body: Form(
        key: form,
        child: Column(
          children: [
            Image.asset(
              "assets/images/logo.png",
              height: 100,
              width: 100,
            ),
            Container(
              margin: EdgeInsets.all(10),
              child: TextFormField(
                controller: email,
                validator: (String? value){
                  if(value == null || value == ""){
                    return "Email field is required";
                  }

                  return null;
                },
                decoration: InputDecoration(
                    hintText: "Enter an email",
                    prefixIcon: Icon(Icons.accessibility_outlined)),
              ),
            ),
            Container(
              margin: EdgeInsets.all(10),
              child: TextFormField(
                controller: password,
                validator: (String? value){
                  if(value == null || value == ""){
                    return "Password field is required";
                  }
                  return null;
                },
                obscureText: hidePassword,
                decoration: InputDecoration(
                    hintText: "Enter your password",
                    prefixIcon: Icon(Icons.password),
                    suffixIcon: !hidePassword
                        ? InkWell(
                            onTap: () {
                              setState(() {
                                hidePassword = !hidePassword;
                              });
                            },
                            child: Icon(Icons.visibility))
                        : InkWell(
                            onTap: () {
                              setState(() {
                                hidePassword = !hidePassword;
                              });
                            },
                            child: Icon(Icons.visibility_off))),
              ),
            ),
            ElevatedButton(onPressed: (){
                if(form.currentState!.validate()){
                  login();
                }else{
                  print("Fail");
                }
            }, child: Text("Login")),
            ElevatedButton(
                onPressed: () {
                  // Navigator.of(context).push(MaterialPageRoute(
                  //   builder: (BuildContext context) => RegisterScreen(),
                  // ));
                  Navigator.of(context).pushReplacementNamed("/register");
                },
                child: Text("Register Now"))
          ],
        ),
      ),
    );
  }
}
