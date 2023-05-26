import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:gde/resources/auth_method.dart';
import 'package:gde/utils/utilis.dart';
import 'package:gde/widgets/text_field.dart';
import 'package:image_picker/image_picker.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUp();
}

class _SignUp extends State<SignUp> {
  final TextEditingController _mailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  Uint8List? _img;
  @override
  void dispose() {
    _mailController.dispose();
    _bioController.dispose();
    _passwordController.dispose();
    _usernameController.dispose();
    super.dispose();
  }

  selectImage() async {
    Uint8List im = await imagePicker(ImageSource.gallery);
    setState(() {
      _img = im;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //svg,
              Flexible(
                flex: 2,
                child: Center(),
              ),
              // Image(
              //   image: AssetImage('assets/img/logo.png'),
              //   height: 100,
              // ),
              //circle pile,
              Stack(
                children: [
                  _img == null
                      ? CircleAvatar(
                          backgroundImage: AssetImage('assets/img/default.jpg'),
                          radius: 64,
                        )
                      : CircleAvatar(
                          backgroundImage: MemoryImage(_img!),
                          radius: 64,
                        ),
                  Positioned(
                    bottom: -10,
                    right: 0,
                    child: IconButton(
                      onPressed: () {
                        selectImage();
                      },
                      icon: Icon(
                        Icons.add_a_photo,
                        size: 30,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 24,
              ),
              //TextField,
              TextFieldInput(
                controller: _mailController,
                hint: 'enter your mail',
                type: TextInputType.emailAddress,
              ),
              const SizedBox(
                height: 24,
              ),
              TextFieldInput(
                controller: _usernameController,
                hint: 'enter your username',
                type: TextInputType.emailAddress,
              ),
              const SizedBox(
                height: 24,
              ),
              TextFieldInput(
                controller: _passwordController,
                hint: 'enter your password',
                type: TextInputType.name,
                isPass: true,
              ),
              const SizedBox(
                height: 24,
              ),
              TextFieldInput(
                controller: _bioController,
                hint: 'enter your bio',
                type: TextInputType.emailAddress,
              ),
              const SizedBox(
                height: 24,
              ),
              InkWell(
                onTap: () => AuthMethods().signUpUser(
                  email: _mailController.text,
                  password: _passwordController.text,
                  username: _usernameController.text,
                  bio: _bioController.text,
                ),
                child: Container(
                  width: double.infinity,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  decoration: ShapeDecoration(
                      color: Colors.blue,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(4)))),
                  child: Text('Sign Up'),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              Flexible(
                flex: 2,
                child: Center(),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Text('Don\'t you have account ?'),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Text(
                          'Sign up',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
