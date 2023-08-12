import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gde/resources/firestore_methods.dart';
import 'package:gde/screens/button_follow.dart';
import 'package:gde/screens/login_screen.dart';
import 'package:gde/utils/snackbar.dart';

class ProfilScreen extends StatefulWidget {
  const ProfilScreen({super.key, required this.uid});
  final String uid;

  @override
  State<ProfilScreen> createState() => _ProfilScreenState();
}

class _ProfilScreenState extends State<ProfilScreen> {
  @override
  void initState() {
    getData();
    super.initState();
    setState(() {
      isloading = true;
    });
  }

  var userData = {};
  int postLen = 0;
  int followers = 0;
  int following = 0;
  bool isfollowing = false;
  bool isloading = false;

  getData() async {
    try {
      var documentSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.uid)
          .get();
      //get the post
      var postSnap = await FirebaseFirestore.instance
          .collection('posts')
          .where('uid', isEqualTo: widget.uid)
          .get();
      postLen = postSnap.docs.length;
      userData = documentSnapshot.data()!;
      followers = documentSnapshot.data()!['followers'].length;
      following = documentSnapshot.data()!['followings'].length;
      isfollowing = documentSnapshot
          .data()!['followers']
          .contains(FirebaseAuth.instance.currentUser!.uid);
    } catch (e) {
      showSnackBar(e.toString(), context);
    }
    setState(() {
      isloading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return isloading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Scaffold(
            backgroundColor: Colors.black,
            appBar: AppBar(
              backgroundColor: Colors.black,
              title: Text(userData['username']),
            ),
            body: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 40,
                          backgroundColor: Colors.grey,
                          backgroundImage: NetworkImage(userData['photoUrl']),
                        ),
                        Expanded(
                          flex: 1,
                          child: Column(
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  buildStateColum(postLen, 'posts'),
                                  buildStateColum(followers, 'followers'),
                                  buildStateColum(following, 'following')
                                ],
                              ),
                              Row(
                                children: [
                                  FirebaseAuth.instance.currentUser!.uid ==
                                          widget.uid
                                      ? ButtomFollow(
                                          label: 'Sign Out',
                                          function: () async {
                                            await FirestoreMedthods().signOut();
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        LoginScreen()));
                                          },
                                        )
                                      : isfollowing
                                          ? ButtomFollow(
                                              label: 'Unfollow',
                                              function: () async {
                                                await FirestoreMedthods()
                                                    .follow(
                                                        FirebaseAuth.instance
                                                            .currentUser!.uid,
                                                        userData['uid']);
                                                setState(() {
                                                  isfollowing = true;
                                                  followers--;
                                                });
                                              },
                                            )
                                          : ButtomFollow(
                                              label: 'Follow',
                                              function: () async {
                                                await FirestoreMedthods()
                                                    .follow(
                                                        FirebaseAuth.instance
                                                            .currentUser!.uid,
                                                        userData['uid']);
                                                setState(() {
                                                  isfollowing = true;
                                                  followers++;
                                                });
                                              },
                                            )
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.only(top: 15),
                      child: Text(
                        userData['username'],
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.only(top: 1),
                      child: Text(userData['bio']),
                    )
                  ]),
                ),
                Divider(),
                FutureBuilder(
                  future: FirebaseFirestore.instance
                      .collection('posts')
                      .where('uid', isEqualTo: widget.uid)
                      .get(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return GridView.builder(
                      shrinkWrap: true,
                      itemCount: (snapshot.data! as dynamic).docs.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 5,
                          mainAxisSpacing: 1.5,
                          childAspectRatio: 1),
                      itemBuilder: (context, index) {
                        DocumentSnapshot snap =
                            (snapshot.data! as dynamic).docs[index];
                        return Container(
                          child: Image.network(
                            (snap.data()! as dynamic)['postUrl'],
                            fit: BoxFit.cover,
                          ),
                        );
                      },
                    );
                  },
                )
              ],
            ),
          );
  }

  Column buildStateColum(int nume, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          nume.toString(),
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        Container(
          margin: const EdgeInsets.only(top: 10),
          child: Text(
            label.toString(),
            style: TextStyle(
                fontSize: 15, fontWeight: FontWeight.bold, color: Colors.grey),
          ),
        )
      ],
    );
  }
}
