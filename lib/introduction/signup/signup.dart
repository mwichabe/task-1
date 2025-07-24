import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:task/Dashboard/home.dart';
import 'package:task/Model/signup.dart';
import 'package:task/constant/constant.dart';
import 'package:task/introduction/login/login.dart';
import 'package:task/introduction/signup/custom_text_field.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool isLoading = false;
  final _auth = FirebaseAuth.instance;
  //form key
  final _formKey = GlobalKey<FormState>();
  //editing Controllers
  final TextEditingController _emailEditingController = TextEditingController();
  final TextEditingController phoneEditingController = TextEditingController();
  final TextEditingController _passwordEditingController =
      TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _userNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    bool canPop = false;
    return PopScope(
      canPop: canPop,
      onPopInvoked: (bool value) {
        setState(() {
          canPop = !value;
        });

        if (canPop) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Cannot exit App"),
              duration: Duration(milliseconds: 1500),
            ),
          );
        }
      },
      child: Scaffold(
        body: Material(
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(ConstanceData.splashBg),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 28.0, right: 28.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 100),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Hey Good to see you\n',
                            style: Theme.of(context)
                                .textTheme
                                .headlineLarge!
                                .copyWith(color: Colors.white, fontSize: 35),
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            'Welcome',
                            style: Theme.of(context)
                                .textTheme
                                .headlineLarge!
                                .copyWith(color: Colors.white, fontSize: 30),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            OurTextFormField(
                              label: 'Email',
                              pasVisible: false,
                              controller: _emailEditingController,
                              validatorText: 'Email Required',
                              regEx: "^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]",
                              regExValidatorText: 'Please enter a valid email',
                              keyboardType: TextInputType.emailAddress,
                              iconData: Icons.email,
                              isBio: false,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            OurTextFormField(
                              label: "Phone",
                              pasVisible: false,
                              controller: phoneEditingController,
                              validatorText: 'Phone Required',
                              regEx: '',
                              regExValidatorText: '',
                              keyboardType: TextInputType.phone,
                              iconData: Icons.phone,
                              isBio: false,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            OurTextFormField(
                              label: 'First Name',
                              validatorText: 'Please enter a valid first name.',
                              regEx:
                                  r'^[a-zA-Z]+(?:-[a-zA-Z]+)*(?: [a-zA-Z]+(?:-[a-zA-Z]+)*)*$',
                              regExValidatorText:
                                  'Please enter a valid first name.',
                              keyboardType: TextInputType.text,
                              iconData: Icons.person,
                              pasVisible: false,
                              controller: _firstNameController,
                              isBio: false,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            OurTextFormField(
                              label: 'Last Name',
                              validatorText: 'Please enter a valid first name.',
                              regEx:
                                  r'^[a-zA-Z]+(?:-[a-zA-Z]+)*(?: [a-zA-Z]+(?:-[a-zA-Z]+)*)*$',
                              regExValidatorText:
                                  'Please enter a valid first name.',
                              keyboardType: TextInputType.text,
                              iconData: Icons.person,
                              pasVisible: false,
                              controller: _lastNameController,
                              isBio: false,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            OurTextFormField(
                              label: 'Username',
                              validatorText: 'Please enter your username.',
                              regEx: r'^[a-zA-Z0-9_.]+$',
                              regExValidatorText: 'Username taken',
                              keyboardType: TextInputType.text,
                              iconData: Icons.person,
                              controller: _userNameController,
                              pasVisible: false,
                              isBio: false,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            OurTextFormField(
                              label: 'Create your Password',
                              validatorText: 'Please enter your password.',
                              regEx:
                                  r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!$@#&*~]).{6,}$',
                              regExValidatorText: 'Password should: \n'
                                  ' Have at least 6 characters\n '
                                  'Have a symbol \n'
                                  'Have an uppercase \n'
                                  'Have a numeric number \n'
                                  'eg. Best@1',
                              keyboardType: TextInputType.text,
                              iconData: Icons.key,
                              controller: _passwordEditingController,
                              pasVisible: true,
                              isBio: false,
                            ),
                          ],
                        )),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              'Login ',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.start,
                            ),
                          ],
                        ),
                        onTap: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const LogIn()));
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    SizedBox(
                      height: 40,
                      width: 160,
                      child: ElevatedButton(
                        onPressed: () {
                          //
                          register(_emailEditingController.text,
                              _passwordEditingController.text);
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: lightGreyColor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10))),
                        child: const Text(
                          'Sign Up',
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  postDetailsToFirestore() async {
    // calling firestore
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;
    //calling usermodel
    UserModelOne userModel = UserModelOne(uid: '');
    // sending content
    userModel.email = user!.email;
    userModel.uid = user.uid;
    userModel.firstName = _firstNameController.text;
    userModel.userName = _userNameController.text;
    userModel.lastName = _lastNameController.text;
    userModel.phoneNumber = phoneEditingController.text;
    await firebaseFirestore
        .collection('users')
        .doc(user.uid)
        .set(userModel.toMap());
    Navigator.pushReplacement((context),
        MaterialPageRoute(builder: (context) => const Home()));
    Fluttertoast.showToast(
      msg: 'Account created successfully',
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.green,
      timeInSecForIosWeb: 1,
      fontSize: 16,
    );
  }

  void register(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });
      await _auth
          .createUserWithEmailAndPassword(
              email: _emailEditingController.text,
              password: _passwordEditingController.text)
          .then((value) => {postDetailsToFirestore()})
          .catchError((e) {
        log(e!.message);
        // Show error message
        String errorMessage = 'An error occurred during sign-up.';
        if (e is FirebaseAuthException) {
          switch (e.code) {
            case 'weak-password':
              errorMessage =
                  'The password is too weak. Please use a stronger password.';
              break;
            case 'email-already-in-use':
              errorMessage =
                  'The email address is already in use. Please choose a different email.';
              break;
            default:
              errorMessage =
                  'An error occurred while creating your account: ${e.message}';
          }
        }
        Fluttertoast.showToast(
          msg: errorMessage,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
          timeInSecForIosWeb: 1,
          fontSize: 16,
        );
      });
    }
    setState(() {
      isLoading = false;
    });
  }
}