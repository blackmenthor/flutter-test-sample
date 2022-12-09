
import 'package:bloc/bloc.dart';
import 'package:flutter_test_sample/core/api/api.dart';
import 'package:flutter_test_sample/core/di/di.dart';
import 'package:flutter_test_sample/core/models/user.dart';

abstract class UserDetailState {}

class LoadingUserDetailState extends UserDetailState {}

class ErrorUserDetailState extends UserDetailState {

  final dynamic error;
  final StackTrace? trace;

  ErrorUserDetailState({
    required this.error,
    required this.trace,
  });

  ErrorUserDetailState copyWith({
    dynamic error,
    StackTrace? trace,
  }) {
    return ErrorUserDetailState(
      error: error ?? this.error,
      trace: trace ?? this.trace,
    );
  }

  @override
  bool operator ==(Object other) => other is ErrorUserDetailState
      && other.error == error;

  @override
  int get hashCode => error.hashCode;

}

class LoadedUserDetailState extends UserDetailState {

  final User user;

  LoadedUserDetailState({
    required this.user,
  });

  LoadedUserDetailState copyWith({
    User? user,
  }) {
    return LoadedUserDetailState(
      user: user ?? this.user,
    );
  }

}

class UserDetailCubit extends Cubit<UserDetailState> {
  UserDetailCubit({
      required this.id,
  }) : super(LoadingUserDetailState());

  final int id;

  final api = getIt.get<Api>();

  Future<void> fetchData() async {
    try {
      final url = 'https://reqres.in/api/users/$id';

      final resp = await api.get(url: url);
      final json = resp;
      final data = json!['data'];

      final user = User.fromJson(data);

      emit(
        LoadedUserDetailState(user: user),
      );
    } catch (ex, trace) {
      emit(
        ErrorUserDetailState(
          error: ex,
          trace: trace,
        ),
      );
    }
  }

}