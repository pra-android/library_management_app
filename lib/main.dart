import 'package:flutter/material.dart';
import 'package:library_management_app/Homepage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final titlecontroller = TextEditingController();
  final passwordcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset(
              "assets/creative2.png",
              height: 450,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                    child: Text("Libraray Management App",
                        style: TextStyle(color: Colors.white, fontSize: 20))),
              ],
            ),
            SizedBox(
              height: 25,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 17.0),
              child: TextFormField(
                controller: titlecontroller,
                decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    hintText: "UserName",
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(45),
                        borderSide: BorderSide(color: Colors.white)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(45),
                        borderSide: BorderSide(color: Colors.white)),
                    prefixIcon: Icon(
                      Icons.person,
                      color: Colors.deepPurple,
                    )),
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 17.0),
              child: TextFormField(
                controller: passwordcontroller,
                obscureText: true,
                decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    hintText: "Password",
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(45),
                        borderSide: BorderSide(color: Colors.white)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(45),
                        borderSide: BorderSide(color: Colors.white)),
                    prefixIcon: Icon(
                      Icons.key_rounded,
                      color: Colors.deepPurple,
                    )),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () {
                setState(() {
                  if (titlecontroller.text == "admin" ||
                      passwordcontroller.text == "pass") {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => HomePage()));
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text("Incorrect Username or Password")));
                  }
                });
              },
              child: Container(
                width: 330,
                height: 52,
                child: Center(
                    child: Text(
                  "SIGN IN",
                  style: TextStyle(color: Colors.deepPurple, fontSize: 18),
                )),
                decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(30)),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                    child: Text("Please Enter your Credentials",
                        style: TextStyle(color: Colors.white, fontSize: 13))),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
