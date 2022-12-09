import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test_sample/core/blocs/user_list_cubit.dart';
import 'package:flutter_test_sample/pages/user_detail_page.dart';

class UserListPage extends StatefulWidget {
  const UserListPage({
    Key? key,
  }) : super(key: key);

  @override
  State<UserListPage> createState() => _UserListPageState();
}

class _UserListPageState extends State<UserListPage> {

  late UserListCubit userListCubit;

  @override
  void initState() {
    super.initState();

    userListCubit = UserListCubit();
    userListCubit.fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => userListCubit,
        child: Builder(
          builder: (context)
            => Scaffold(
              appBar: AppBar(
                title: const Text('User list page'),
              ),
              body: BlocBuilder<UserListCubit, UserListState>(
                builder: (context, state) {
                  if (state is LoadingUserListState) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  if (state is ErrorUserListState) {
                    return Center(
                      child: Text(
                        'Error: ${state.error}',
                        textAlign: TextAlign.center,
                      ),
                    );
                  }

                  final users = (state as LoadedUserListState).users;

                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 16,),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text(
                          'Users:',
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16,),
                      Expanded(
                        child: users.isEmpty
                            ? const Center(
                              child: Text(
                                'No users available',
                                textAlign: TextAlign.center,
                              ),
                            )
                            : ListView.builder(
                            itemCount: users.length,
                            itemBuilder: (context, index) {
                              final user = users[index];
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
                            },
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
        ),
    );
  }
}
