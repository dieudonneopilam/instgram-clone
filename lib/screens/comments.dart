import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gde/bloc/current.user/current_user_bloc.dart';
import 'package:gde/resources/firestore_methods.dart';
import 'package:gde/widgets/comment_card.dart';

class CommentsPage extends StatefulWidget {
  final snap;
  const CommentsPage({super.key, required this.snap});

  @override
  State<CommentsPage> createState() => _CommentsPageState();
}

class _CommentsPageState extends State<CommentsPage> {
  final TextEditingController commentController = TextEditingController();
  @override
  void dispose() {
    commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CurrentUserBloc, CurrentUserState>(
      builder: (context, state) {
        (state as CurrentUserInitial);
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.black,
            title: Text('Comments'),
            centerTitle: false,
          ),
          body: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('posts')
                .doc(widget.snap['postId'])
                .collection('comments')
                .orderBy('datePublished', descending: true)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              }
              return ListView.builder(
                itemCount: (snapshot.data! as dynamic).docs.length,
                itemBuilder: (context, index) => CommentCard(
                    snap: (snapshot.data! as dynamic).docs[index].data()),
              );
            },
          ),
          bottomNavigationBar: SafeArea(
              child: Container(
            height: kTextTabBarHeight,
            margin: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            padding: const EdgeInsets.only(
              left: 16,
              right: 8,
            ),
            child: Row(
              children: [
                CircleAvatar(
                    backgroundImage: NetworkImage(state.user.photoUrl),
                    radius: 18),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16, right: 8),
                    child: TextField(
                      controller: commentController,
                      decoration: InputDecoration(
                          hintText: 'comment as ${state.user.username}',
                          border: InputBorder.none),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () async {
                    await FirestoreMedthods().postComment(
                        widget.snap['postId'],
                        state.user.uid,
                        commentController.text,
                        state.user.username,
                        state.user.photoUrl);
                  },
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                    child: Text(
                      'Post',
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                )
              ],
            ),
          )),
        );
      },
    );
  }
}
