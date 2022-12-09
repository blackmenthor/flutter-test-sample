import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test_sample/core/blocs/user_detail_cubit.dart';

class UserDetailPage extends StatefulWidget {
  const UserDetailPage({
    Key? key,
    required this.id,
  }) : super(key: key);

  final int id;

  @override
  State<UserDetailPage> createState() => _UserDetailPageState();
}

class _UserDetailPageState extends State<UserDetailPage> {

  late UserDetailCubit userDetailCubit;

  @override
  void initState() {
    super.initState();

    userDetailCubit = UserDetailCubit(
      id: widget.id,
    );
    userDetailCubit.fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => userDetailCubit,
        child: Builder(
          builder: (context)
            => Scaffold(
              appBar: AppBar(
                title: const Text('User detail page'),
              ),
              body: BlocBuilder<UserDetailCubit, UserDetailState>(
                builder: (context, state) {
                  if (state is LoadingUserDetailState) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  if (state is ErrorUserDetailState) {
                    return Center(
                      child: Text(
                        'Error: ${state.error}',
                        textAlign: TextAlign.center,
                      ),
                    );
                  }

                  final user = (state as LoadedUserDetailState).user;

                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: CachedNetworkImage(
                              imageUrl: user.avatar,
                              fit: BoxFit.cover,
                              height: 72,
                              width: 72,
                          ),
                        ),
                        const SizedBox(width: 16,),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 16,),
                              Text(
                                'Name: ${user.firstName} ${user.lastName}',
                                style: const TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(height: 16,),
                              Text(
                                'Email: ${user.email}',
                                style: const TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
        ),
    );
  }
}
