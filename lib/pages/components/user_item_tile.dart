import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test_sample/core/models/user.dart';
import 'package:flutter_test_sample/pages/user_detail_page.dart';

class UserItemTile extends StatelessWidget {
  const UserItemTile({
    Key? key,
    required this.user,
  }) : super(key: key);

  final User user;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context)
            => UserDetailPage(id: user.id),
          ),
        );
      },
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: CachedNetworkImage(
          imageUrl: user.avatar,
          height: 72,
          width: 72,
          fit: BoxFit.cover,
        ),
      ),
      title: Text(
        '${user.firstName} ${user.lastName}',
      ),
      subtitle: Text(
        user.email,
      ),

    );
  }
}
