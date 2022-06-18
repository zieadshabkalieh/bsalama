import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Model/following.dart';

class Favorite extends StatelessWidget {
  const Favorite({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Consumer<Following>(
      builder: (BuildContext context, Following value, Widget? child) {
        return ListView.builder(
          itemCount: value.followingListdestination.length + 1,
          itemBuilder: (context, index) {
            if (index == 0) {
              return Padding(
                padding: EdgeInsets.all(40.0),
                child: Text("You Are Following"),
              );
            } else {
              return Center(
                child:ListTile(
                  // leading: Column(
                  //   children: [
                  //     Text(value.followingListdate[index - 1]),
                  //     SizedBox(
                  //       height: 10,
                  //     ),
                  //     Text(value.followingListtime[index - 1]),
                  //   ],
                  // ),
                  title: Text(value.followingListdestination[index - 1]),
                  subtitle: Text(value.followingListsource[index - 1]),
                )
                // Text(value.followingList[index - 1]),
              );
            }
          },
        );
      },
    ));
  }
}
