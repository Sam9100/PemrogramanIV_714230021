import 'package:dio_contact/services/api_services.dart';
import 'package:dio_contact/view/screen/home_page.dart';
import 'package:dio_contact/services/auth_manager.dart';
import 'package:dio_contact/model/login_model.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// class LoginInput {
//   final String username;
//   final String password;

//   LoginInput({required this.username, required this.password});

//   Map<String, dynamic> toJson() => {"username": username, "password": password};
// }

// class LoginResponse {
//   final String? token;
//   final String message;
//   final int status;

//   LoginResponse({this.token, required this.message, required this.status});

//   factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
//     token: json["token"],
//     message: json["message"],
//     status: json["status"],
//   );
// }

// final dio = Dio();

// Future<LoginResponse?> login(LoginInput login) async {
//   try {
//     final response = await dio.post('/login', data: login.toJson());
//     if (response.statusCode == 200) {
//       return LoginResponse.fromJson(response.data);
//     }
//     return null;
//   } on DioException catch (e) {
//     if (e.response != null && e.response!.statusCode != 200) {
//       return LoginResponse.fromJson(e.response!.data);
//     }
//     rethrow;
//   } catch (e) {
//     rethrow;
//   }
// }

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  final ApiServices _dataservice = ApiServices();

  @override
  void initState() {
    super.initState();
    checkLogin();
  }

  void checkLogin() async {
    bool isLoggedIn = await AuthManager.isLoggedIn();
    if (isLoggedIn) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => const HomePage(),
        ),
        (route) => false,
      );
    }
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  String? _validateUsername(String? value) {
    if (value != null && value.length < 4) {
      return 'Masukkan minimal 4 karakter';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value != null && value.length < 3) {
      return 'Masukkan minimal 3 karakter';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(title: const Text('Login Page')),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      validator: _validateUsername,
                      controller: _usernameController,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.account_circle_rounded),
                        hintText: 'Write username here...',
                        labelText: 'Username',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        fillColor: Color.fromARGB(255, 242, 254, 255),
                        filled: true,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      obscureText: true,
                      controller: _passwordController,
                      validator: _validatePassword,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.password_rounded),
                        hintText: 'Write your password here...',
                        labelText: 'Password',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        fillColor: Color.fromARGB(255, 242, 254, 255),
                        filled: true,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: () async {
                        final isValidForm = _formKey.currentState!.validate();
                        if (isValidForm) {
                          final postModel = LoginInput(
                            username: _usernameController.text,
                            password: _passwordController.text,
                          );

                          LoginResponse? res =
                              await _dataservice.login(postModel);

                          if (res!.status == 200) {
                            SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                            await prefs.setString('token', res.token ?? '');

                            await AuthManager.login(_usernameController.text);
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const HomePage(),
                              ),
                              (route) => false,
                            );
                          } else {
                            displaySnackbar(res.message);
                          }
                        }
                      },
                      child: const Text('Login'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  dynamic displaySnackbar(String msg) {
    return ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(msg)));
  }
}