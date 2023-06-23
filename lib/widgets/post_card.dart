import 'package:flutter/material.dart';

class PostCard extends StatelessWidget {
  const PostCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              CircleAvatar(
                backgroundImage: AssetImage('assets/img/default.jpg'),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'username',
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
        SizedBox(
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 0.50,
          child: Image.asset(
            'assets/img/default.jpg',
            fit: BoxFit.cover,
          ),
        ),
        Row(
          children: [
            IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.favorite,
                  color: Colors.red,
                )),
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DefaultTextStyle(
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(fontWeight: FontWeight.bold),
                child: Text(
                  '1,231 likes',
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
                      TextSpan(text: 'username'),
                      TextSpan(text: ' Hey this'),
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
                    '22/01/2015',
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
