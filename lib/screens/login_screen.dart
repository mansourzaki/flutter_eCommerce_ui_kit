import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: Padding(
          padding: EdgeInsets.only(top: 35, right: 18),
          child: TextButton(
              onPressed: () {},
              child: Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    // Navigator.of(context).push(MaterialPageRoute(
                    //   builder: (context) => SignUpScreen(),
                    // ));
                  },
                  child: Text('Create account',
                      style: TextStyle(
                        color: Color(0xFF4447E2),
                        fontSize: 18,
                      )),
                ),
              )),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 82,
            ),
            Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                'Login',
                style: TextStyle(fontWeight: FontWeight.w900, fontSize: 30),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            TextField(
              decoration: InputDecoration(
                  hintText: 'Email',
                  filled: true,
                  fillColor: Color.fromARGB(255, 244, 241, 241),
                  border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(11))),
            ),
            SizedBox(
              height: 14,
            ),
            TextField(
              decoration: InputDecoration(
                  hintText: 'Password',
                  filled: true,
                  fillColor: Color.fromARGB(255, 244, 241, 241),
                  border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(11))),
            ),
            SizedBox(
              height: 14,
            ),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                  onPressed: () {},
                  child: Text(
                    'Forgot Password?',
                    style: TextStyle(color: Color(0xFF4447E2)),
                  )),
            ),
            SizedBox(
              height: 23,
            ),
            Row(
              children: const [
                Expanded(
                    child: Divider(
                  endIndent: 20,
                  thickness: 1,
                  color: Color(0xFFD9D9D9),
                )),
                Text('or login with'),
                Expanded(
                    child: Divider(
                  indent: 20,
                  thickness: 1,
                  color: Color(0xFFD9D9D9),
                )),
              ],
            ),
            SizedBox(
              height: 22,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 99,
                  height: 60,
                  child: Image.asset('assets/images/google-logo.png'),
                  decoration: BoxDecoration(
                      color: Color.fromARGB(255, 244, 241, 241),
                      borderRadius: BorderRadius.circular(12)),
                ),
                Container(
                  width: 99,
                  height: 60,
                  child: Center(
                    child: FaIcon(
                      FontAwesomeIcons.facebook,
                      color: Colors.blue,
                    ),
                  ),
                  decoration: BoxDecoration(
                      color: Color.fromARGB(255, 244, 241, 241),
                      borderRadius: BorderRadius.circular(12)),
                ),
                Container(
                  width: 99,
                  height: 60,
                  child: Image.asset(
                    'assets/images/apple.png',
                    width: 22,
                    height: 22,
                  ),
                  decoration: BoxDecoration(
                      color: Color.fromARGB(255, 244, 241, 241),
                      borderRadius: BorderRadius.circular(12)),
                ),
              ],
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.all(20),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(11)),
                      primary: Color(0xFF4447E2),
                      padding: const EdgeInsets.all(20)),
                  onPressed: () {
                    // Navigator.of(context).pushReplacement(MaterialPageRoute(
                    //   builder: (context) => MainScreen(),
                    // ));
                  },
                  child: Text('Login'),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
