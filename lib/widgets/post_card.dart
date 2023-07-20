import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gde/bloc/current.user/current_user_bloc.dart';
import 'package:gde/widgets/like.animation.dart';
import 'package:intl/intl.dart';

class PostCard extends StatefulWidget {
  const PostCard({super.key, required this.snap});
  final snap;

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  bool isLikeAnimating = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundImage: NetworkImage(widget.snap['profilImage']),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.snap['username'],
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
              ),
              IconButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => Dialog(
                          child: ListView(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        shrinkWrap: true,
                        children: [],
                      )),
                    );
                  },
                  icon: Icon(Icons.more_vert))
            ],
          ),
        ),
        GestureDetector(
          onDoubleTap: () {
            setState(() {
              isLikeAnimating = true;
            });
          },
          child: Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.50,
                child: Image.network(
                  widget.snap['postUrl'],
                  fit: BoxFit.cover,
                ),
              ),
              AnimatedOpacity(
                duration: Duration(milliseconds: 200),
                opacity: isLikeAnimating ? 1 : 0,
                child: LikeAnimation(
                  child: const Icon(
                    Icons.favorite,
                    size: 100,
                  ),
                  isAnimation: isLikeAnimating,
                  duration: Duration(milliseconds: 400),
                  onEnd: () {
                    setState(() {
                      isLikeAnimating = false;
                    });
                  },
                ),
              )
            ],
          ),
        ),
        Row(
          children: [
            BlocBuilder<CurrentUserBloc, CurrentUserState>(
              builder: (context, state) {
                (state as CurrentUserInitial);
                return LikeAnimation(
                  isAnimation: widget.snap['likes'].contains(state.user.uid),
                  smallike: true,
                  child: IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.favorite,
                        color: Colors.red,
                      )),
                );
              },
            ),
            IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.comment_outlined,
                )),
            IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.send,
                  color: Colors.white,
                )),
            Expanded(
                child: Align(
              alignment: Alignment.bottomRight,
              child: IconButton(
                  onPressed: () {}, icon: Icon(Icons.bookmark_border)),
            ))
          ],
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DefaultTextStyle(
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(fontWeight: FontWeight.bold),
                child: Text(
                  '${widget.snap['likes'].length} likes',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.only(top: 5),
                child: RichText(
                  text: TextSpan(
                    style: TextStyle(),
                    children: [
                      TextSpan(
                          text: widget.snap['username'] + '  ',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 17)),
                      TextSpan(
                          text: widget.snap['description'],
                          style: TextStyle(fontSize: 17)),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {},
                child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Text(
                      'View all 200 comments',
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                          fontWeight: FontWeight.bold),
                    )),
              ),
              Container(
                  padding: const EdgeInsets.symmetric(vertical: 0),
                  child: Text(
                    DateFormat.yMMMd()
                        .format(widget.snap['datePublished'].toDate()),
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                        fontWeight: FontWeight.bold),
                  ))
            ],
          ),
        )
      ],
    );
  }
}
