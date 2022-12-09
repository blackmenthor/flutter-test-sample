import 'package:flutter_test_sample/core/blocs/user_detail_cubit.dart';
import 'package:mockito/annotations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_test_sample/core/api/api.dart';
import 'package:flutter_test_sample/core/di/di.dart';
import 'package:flutter_test_sample/core/models/user.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/mockito.dart';

@GenerateNiceMocks([MockSpec<Api>()])
import 'user_detail_cubit_test.mocks.dart';
void main() {

  group('UserDetailCubit tests', () {
    final mockApi = MockApi();
    final exception = Exception();

    setUpAll(() {
      getIt.allowReassignment = true;
      getIt.registerSingleton<Api>(mockApi);
    });

    blocTest<UserDetailCubit, UserDetailState>(
      'emits Error when got error from API',
      build: () => UserDetailCubit(id: 0),
      setUp: () {
        when(mockApi.get(url: 'https://reqres.in/api/users/0'))
            .thenThrow(exception);
      },
      act: (bloc) => bloc.fetchData(),
      expect: () => [
        ErrorUserDetailState(
          error: exception,
          trace: null,
        )
      ],
    );
  });

}