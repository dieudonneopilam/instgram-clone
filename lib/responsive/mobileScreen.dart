import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gde/bloc/bottom.navigation.bar/bottom_navigation_bar_bloc.dart';
import 'package:gde/bloc/current.user/current_user_bloc.dart';
import 'package:gde/screens/add.post.dart';
import 'package:gde/screens/feed_screen.dart';

class MobileScreenLayout extends StatefulWidget {
  const MobileScreenLayout({super.key});

  @override
  State<MobileScreenLayout> createState() => _MobileScreenLayoutState();
}

class _MobileScreenLayoutState extends State<MobileScreenLayout> {
  String username = '';

  List<Widget> pages = [
    FeedScreen(),
    Center(child: Text('salut')),
    AddPost(),
    Text('data'),
    Text('data')
  ];

  @override
  void initState() {
    context.read<CurrentUserBloc>().add(OnChanged());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomNavigationBarBloc, BottomNavigationBarState>(
      builder: (context, state) {
        return Scaffold(
            body: pages[(state as BottomNavigationBarInitial).index],
            bottomNavigationBar: CupertinoTabBar(
              activeColor: Colors.white,
              backgroundColor: Colors.black,
              currentIndex: (state).index,
              onTap: (value) => context
                  .read<BottomNavigationBarBloc>()
                  .add(ChangedIndex(index: value)),
              items: [
                BottomNavigationBarItem(icon: Icon(Icons.home), label: 'home'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.search), label: 'search'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.add_circle), label: 'add'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.favorite), label: 'favorite'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.person), label: 'person')
              ],
            ));
      },
    );
  }
}
