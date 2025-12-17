import 'package:ecommerce_app/modules/home_bottom.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(239, 255, 255, 255),
      body: SafeArea(
          child: Container(
        decoration: BoxDecoration(
            gradient: RadialGradient(
         center: Alignment.bottomRight,
           radius: 1,
          colors: [ 
            Color(0xFFFF7A18).withOpacity(0.6),
              Color(0xFFFF9F5A).withOpacity(0.35),
              Colors.transparent,
          ]
        )),
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 45,
            ),
            Text("Hello Again!",
                style: Theme.of(context).textTheme.headlineLarge),
            SizedBox(
              height: 30,
            ),
            Text(
              "Welcome back you' ve",
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(fontWeight: FontWeight.w500),
            ),
            Text(
              "been missed!",
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: 26,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              child: TextFormField(
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(fontSize: 14, fontWeight: FontWeight.w400),
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                controller: _emailController,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Field can not be empty!';
                  }
                  if (!RegExp(
                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
                  ).hasMatch(value)) {
                    return "Please enter a valid email address";
                  }
                  return null;
                },
                decoration: InputDecoration(
                    contentPadding:
                        const EdgeInsets.only(top: 20, left: 20, bottom: 20),
                    isDense: true,
                    filled: true,
                    labelText: "Enter email",
                    labelStyle: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(
                            color: Colors.black54,
                            fontSize: 14,
                            fontWeight: FontWeight.w400),
                    fillColor: const Color.fromARGB(255, 255, 255, 255),
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15.0)),
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    enabledBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15.0)),
                      borderSide: BorderSide(color: Colors.white),
                    )),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              child: TextFormField(
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(fontSize: 14, fontWeight: FontWeight.w400),
                keyboardType: TextInputType.visiblePassword,
                controller: _passwordController,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Field can not be empty!';
                  }
                  return null;
                },
                obscureText: _obscurePassword,
                decoration: InputDecoration(
                  contentPadding:
                      const EdgeInsets.only(top: 20, left: 20, bottom: 20),
                  isDense: true,
                  filled: true,
                  labelText: "Password",
                  labelStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.black54,
                      fontSize: 14,
                      fontWeight: FontWeight.w400),
                  fillColor: const Color.fromARGB(255, 255, 255, 255),
                  suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                        });
                      },
                      icon: Icon(_obscurePassword
                          ? Icons.visibility
                          : Icons.visibility_off)),
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15.0)),
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  enabledBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15.0)),
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    right: 23,
                  ),
                  child: GestureDetector(
                    onTap: () {},
                    child: Text("Recovery Password",
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: const Color.fromARGB(231, 0, 0, 0))),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 35,
            ),
            SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                height: 49,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 251, 120, 6),
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12.0))),
                  ),
                  onPressed: () {
                    if(_emailController.text == "testing@example.com" && _passwordController.text == "test12345"){
                      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => HomeBottomScreen()), (Route<dynamic> route) => false);
                    }
                  },
                  child: Center(
                    child: Text("Sign in",
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: Colors.white, fontWeight: FontWeight.bold)),
                  ),
                )),
            SizedBox(
              height: 25,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                    width: 83,
                    child: const Divider(thickness: 2, color: Colors.black54)),
                SizedBox(
                  width: 14,
                ),
                Text(
                  "or continue with",
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      fontWeight: FontWeight.bold, color: Colors.black87),
                ),
                SizedBox(
                  width: 14,
                ),
                SizedBox(
                    width: 83,
                    child: const Divider(thickness: 2, color: Colors.black54)),
              ],
            ),
            SizedBox(
              height: 23,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 80,
                  height: 45,
                  decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      border: Border.all(width: 2, color: Colors.white)),
                  child: Center(
                      child: Image.network(
                    width: 37,
                    height: 37,
                    'http://pngimg.com/uploads/google/google_PNG19635.png',
                  )),
                ),
                SizedBox(
                  width: 20,
                ),
                Container(
                  width: 80,
                  height: 45,
                  decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      border: Border.all(width: 2, color: Colors.white)),
                  child: Center(
                    child: Icon(size: 37, Icons.apple),
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Container(
                  width: 80,
                  height: 45,
                  decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      border: Border.all(width: 2, color: Colors.white)),
                  child: Center(
                    child: Icon(
                      size: 37,
                      Icons.facebook,
                      color: Colors.blueAccent,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 25,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Not a member? ",
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: Color.fromARGB(200, 0, 0, 0),
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  "Register now",
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .copyWith(color: Colors.blueAccent),
                )
              ],
            )
          ],
        ),
      )),
    );
  }
}
