import 'dart:typed_data';

import 'package:flutter/material.dart';
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

  void postImage() {}
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
                _file = file;
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
              leading:
                  IconButton(icon: Icon(Icons.arrow_back), onPressed: () {}),
              title: Text('Post to '),
              actions: [
                TextButton(
                    onPressed: () {},
                    child: Text('Post', style: TextStyle(color: Colors.blue)))
              ],
            ),
            body: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      backgroundImage: AssetImage('assets/img/default.jpg'),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.45,
                      child: TextField(
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
                                  fit: BoxFit.fill,
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
