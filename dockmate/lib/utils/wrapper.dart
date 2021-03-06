import 'package:dockmate/model/user.dart' as usermodel;
import 'package:dockmate/utils/toggleAuthScreens.dart';
import 'package:dockmate/utils/toggleMainScreens.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Wrapper is for tracking the auth status and displaying different screens
class Wrapper extends StatefulWidget {
  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<usermodel.User>(context);
    final userstatus = Provider.of<User>(context);
    final language = Provider.of<String>(context);
    // get the user object as in user.dart

    // print(user);
    if (userstatus != null &&
        (userstatus.emailVerified || userstatus.isAnonymous)) {
      print('user has signed in, should jump to listings');
      return ToggleMainScreens();
    } else if (user == null) {
      print('user = null, not signed in');
      return ToggleAuthScreens(user: null, verified: false);
    } else if (user != null && !userstatus.emailVerified) {
      print('user = $user, not verified');
      return ToggleAuthScreens(user: userstatus, verified: false);
    }
    print(user);
  }
}
