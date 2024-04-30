import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todoapp/models/user_model.dart';
import 'package:todoapp/screens/todo_home_page.dart';
import 'package:todoapp/services/auth_service.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();

  UserModel _userModel = UserModel();
  final AuthService _authService = AuthService();

  final _regKey = GlobalKey<FormState>();
  bool _isLoading = false;

  Future<void> _register() async {
    setState(() {
      _isLoading = true;
    });
    _userModel = UserModel(
      email: _emailController.text,
      password: _passController.text,
      name: _nameController.text,
      status: 1,
      createdAt: DateTime.now(),
    );
    try {
      await Future.delayed(const Duration(seconds: 3));
      final userdata = await _authService.registerUser(_userModel);
      if (userdata != null) {
        // ignore: use_build_context_synchronously
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => const TodoHomePage()),
            (Route<dynamic> route) => false);
      }
    } on FirebaseAuthException catch (e) {
      setState(() {
        _isLoading = false;
      });
      List err = e.toString().split(']');
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            err[1],
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final themedata = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff0E1D3E),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SafeArea(
        child: Container(
          height: double.infinity,
          width: double.infinity,
          padding: const EdgeInsets.all(25),
          child: Stack(
            children: [
              Form(
                key: _regKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Create an Account',
                      style: themedata.textTheme.displayMedium,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      style: themedata.textTheme.displaySmall,
                      controller: _nameController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Enter your Name";
                        }
                      },
                      decoration: InputDecoration(
                        hintText: 'Enter Name',
                        hintStyle: themedata.textTheme.displaySmall,
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Colors.white,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Colors.white,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      style: themedata.textTheme.displaySmall,
                      controller: _emailController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Enter an Email Id";
                        }
                      },
                      decoration: InputDecoration(
                        hintText: 'Enter Email',
                        hintStyle: themedata.textTheme.displaySmall,
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Colors.white,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Colors.white,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      style: themedata.textTheme.displaySmall,
                      controller: _passController,
                      obscureText: true,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Passwaord is Mandatory";
                        }
                      },
                      decoration: InputDecoration(
                        hintText: 'Enter Password',
                        hintStyle: themedata.textTheme.displaySmall,
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Colors.white,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Colors.white,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                      onTap: () async {
                        if (_regKey.currentState!.validate()) {
                          _register();
                          // UserCredential userData = await FirebaseAuth.instance
                          //     .createUserWithEmailAndPassword(
                          //         email: _emailController.text.trim(),
                          //         password: _passController.text.trim());
                          // if (userData != null) {
                          //   FirebaseFirestore.instance
                          //       .collection('user')
                          //       .doc(userData.user!.uid)
                          //       .set({
                          //     'uid': userData.user!.uid,
                          //     'email': userData.user!.email,
                          //     'name': _nameController.text,
                          //     'createdAt': DateTime.now(),
                          //     'status': 1,
                          //   }).then(
                          //     (value) => Navigator.pushAndRemoveUntil(
                          //         context,
                          //         MaterialPageRoute(
                          //             builder: (BuildContext context) =>
                          //                 TodoHomePage()),
                          //         (Route<dynamic> route) => false),
                          //   );
                          // }
                        }
                      },
                      child: Container(
                        height: 48,
                        width: 250,
                        decoration: BoxDecoration(
                          color: Colors.teal,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(
                            'Create account',
                            style: themedata.textTheme.bodyMedium,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Already have an Account',
                          style: themedata.textTheme.displaySmall,
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            'Login',
                            style: themedata.textTheme.displayMedium,
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
              Visibility(
                visible: _isLoading,
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
