
import 'package:bloc/bloc.dart';
import 'package:flutter_test_sample/core/api/api.dart';
import 'package:flutter_test_sample/core/di/di.dart';
import 'package:flutter_test_sample/core/models/user.dart';

abstract class UserListState {}

class LoadingUserListState extends UserListState {}

class ErrorUserListState extends UserListState {

  final dynamic error;
  final StackTrace trace;

  ErrorUserListState({
      required this.error,
      required this.trace,
  });

  ErrorUserListState copyWith({
    dynamic error,
    StackTrace? trace,
  }) {
    return ErrorUserListState(
      error: error ?? this.error,
      trace: trace ?? this.trace,
    );
  }

}

class LoadedUserListState extends UserListState {

  final List<User> users;

  LoadedUserListState({
    required this.users,
  });

  LoadedUserListState copyWith({
    List<User>? users,
  }) {
    return LoadedUserListState(
      users: users ?? this.users,
    );
  }

}

class UserListCubit extends Cubit<UserListState> {
  UserListCubit() : super(LoadingUserListState());

  final api = getIt.get<Api>();

  Future<void> fetchData({
    int page = 1,
  }) async {
    try {
      final resp = await api.get(
        url: 'https://reqres.in/api/users?page=$page',
      );
      final json = resp!;

      final totalUsers = json['total'] as int;
      final currentPage = json['page'] as int;
      final totalPage = json['total_pages'] as int;
      final usersJson = json['data'];
      final userList = <User>[];
      for (final jsonObject in usersJson) {
        final user = User.fromJson(jsonObject);
        userList.add(user);
      }

      emit(
        LoadedUserListState(users: userList),
      );
    } catch (ex, trace) {
      emit(
          ErrorUserListState(
              error: ex,
              trace: trace,
          ),
      );
    }
  }

}