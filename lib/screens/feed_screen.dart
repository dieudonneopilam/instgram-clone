import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gde/bloc/current.user/current_user_bloc.dart';
import 'package:gde/widgets/post_card.dart';

class FeedScreen extends StatelessWidget {
  const FeedScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: BlocBuilder<CurrentUserBloc, CurrentUserState>(
            builder: (context, state) {
              return Text('Instagram');
            },
          ),
          actions: [
            IconButton(onPressed: () {}, icon: Icon(Icons.messenger_outline))
          ],
        ),
        body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('posts').snapshots(),
          builder: (context,
              AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) =>
                  PostCard(snap: snapshot.data!.docs[index].data()),
            );
          },
        ));
  }
}
