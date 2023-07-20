// ignore_for_file: unnecessary_null_comparison

import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gde/bloc/current.user/current_user_bloc.dart';
import 'package:gde/resources/firestore_methods.dart';
import 'package:gde/utils/snackbar.dart';
import 'package:gde/utils/utilis.dart';
import 'package:image_picker/image_picker.dart';

class AddPost extends StatefulWidget {
  const AddPost({super.key});

  @override
  State<AddPost> createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  Uint8List? _file;

  TextEditingController descriptionController = TextEditingController();
  bool loading = false;

  @override
  void dispose() {
    descriptionController.dispose();
    super.dispose();
  }

  Future<void> postImage(
      String uid, String username, String profilImage) async {
    setState(() {
      loading = true;
    });
    try {
      String res = await FirestoreMedthods().uploadPost(
          descriptionController.text, _file!, uid, username, profilImage);
      if (res == "success") {
        showSnackBar('Posted', context);
        clearFile();
      }
    } catch (e) {
      showSnackBar(e.toString(), context);
    }
    setState(() {
      loading = false;
    });
  }

  void clearFile() {
    setState(() {
      _file = null;
    });
  }

  _selectImage(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        title: Text('create a Post'),
        children: [
          SimpleDialogOption(
            child: Text('Take a photo'),
            onPressed: () async {
              Navigator.of(context).pop();
              Uint8List file = await imagePicker(ImageSource.camera);
              setState(() {
                if (file != null) {
                  _file = file;
                }
              });
            },
          ),
          SimpleDialogOption(
            child: Text('Choose from Galery'),
            onPressed: () async {
              Navigator.of(context).pop();
              Uint8List file = await imagePicker(ImageSource.gallery);
              setState(() {
                _file = file;
              });
            },
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return (_file == null)
        ? Center(
            child: IconButton(
                onPressed: () {
                  _selectImage(context);
                },
                icon: Icon(Icons.upload)),
          )
        : Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.black,
              leading: IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {
                    clearFile();
                  }),
              title: Text('Post to '),
              actions: [
                BlocBuilder<CurrentUserBloc, CurrentUserState>(
                  builder: (context, state) {
                    (state as CurrentUserInitial);
                    return TextButton(
                        onPressed: () => postImage(state.user.uid,
                            state.user.username, state.user.photoUrl),
                        child:
                            Text('Post', style: TextStyle(color: Colors.blue)));
                  },
                )
              ],
            ),
            body: Column(
              children: [
                loading
                    ? Container(
                        margin: const EdgeInsets.symmetric(vertical: 5),
                        child: LinearProgressIndicator())
                    : Container(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BlocBuilder<CurrentUserBloc, CurrentUserState>(
                      builder: (context, state) {
                        return CircleAvatar(
                          backgroundImage: NetworkImage(
                              (state as CurrentUserInitial).user.photoUrl),
                        );
                      },
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.45,
                      child: TextField(
                        controller: descriptionController,
                        maxLines: 8,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Write a caption ...'),
                      ),
                    ),
                    SizedBox(
                      width: 45,
                      height: 45,
                      child: AspectRatio(
                        aspectRatio: 487 / 451,
                        child: Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  alignment: FractionalOffset.topCenter,
                                  image: MemoryImage(_file!))),
                        ),
                      ),
                    ),
                    const Divider()
                  ],
                )
              ],
            ),
          );
  }
}
