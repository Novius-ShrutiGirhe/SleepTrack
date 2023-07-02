import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class AfterLogin extends StatefulWidget {
  final token;
  const AfterLogin({Key? key, @required this.token}) : super(key: key);

  @override
  State<AfterLogin> createState() => _AfterLoginState();
}

class _AfterLoginState extends State<AfterLogin> {
  late String email;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Map<String, dynamic> jwtDecodedToken = JwtDecoder.decode(widget.token);
    email = jwtDecodedToken['email'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Text(
        email,
        style: TextStyle(fontWeight: FontWeight.bold),
      )),
    );
  }
}
