import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todoapp/screens/login_page.dart';
import 'package:todoapp/screens/todo_home_page.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  String? name;
  String? email;
  String? uid;
  String? token;

  @override
  void initState() {
    getData();
    var d = Duration(seconds: 3);
    Future.delayed(d, () {
      checkLoginStatus();
    });
    //  checkLoginStatus();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          'ToDo',
          style: TextStyle(
            color: Colors.white,
            fontSize: 30,
          ),
        ),
      ),
    );
  }

  getData() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    token = await _pref.getString("token");
    name = await _pref.getString("name");
    email = await _pref.getString("email");
    uid = await _pref.getString("uid");
  }

  Future<void> checkLoginStatus() async {
    if (token == null) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (ctx) => const LoginView(),
        ),
      );
    } else {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (ctx) => const TodoHomePage(),
        ),
      );
    }
  }
}

// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:todoapp/main.dart';
// import 'package:todoapp/screens/login_page.dart';
// import 'package:todoapp/screens/todo_home_page.dart';

// class ScreenSplash extends StatefulWidget {
//   const ScreenSplash({super.key});

//   @override
//   State<ScreenSplash> createState() => _ScreenSplashState();
// }

// class _ScreenSplashState extends State<ScreenSplash> {
//   // once call cheyunath 'initstate'
//   @override
//   void initState() {
//     checkLoggIn();
//     super.initState();
//   }

//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return const Scaffold(
//       body: Center(
//         child: Text(
//           'ToDo',
//           style: TextStyle(
//             color: Colors.white,
//             fontSize: 30,
//           ),
//         ),
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     super.dispose();
//   }

//   Future<void> gotoLogin() async {
//     await Future.delayed(
//       const Duration(seconds: 5),
//     );
//     // ignore: use_build_context_synchronously
//     Navigator.of(context).pushReplacement(
//       MaterialPageRoute(
//         builder: (ctx) => const LoginView(),
//       ),
//     );
//   }

//   Future<void> checkLoggIn() async {
//     final sharedPrefs = await SharedPreferences.getInstance();
//     final userLog = sharedPrefs.getBool(saveValue);
//     if (userLog == null || userLog == false) {
//       gotoLogin();
//     } else {
//       // ignore: use_build_context_synchronously
//       Navigator.of(context).pushReplacement(
//         MaterialPageRoute(
//           builder: (ctx1) => const TodoHomePage(),
//         ),
//       );
//     }
//   }
// }
