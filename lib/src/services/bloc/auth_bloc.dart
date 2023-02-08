import 'package:bloc/bloc.dart';
import 'package:budget_tracker/src/services/bloc/auth_event.dart';
import 'package:budget_tracker/src/services/bloc/auth_state.dart';
import 'package:budget_tracker/src/services/network/auth_repository.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthRepository authRepository = AuthRepository();
  final storage = const FlutterSecureStorage();
  final http.Client httpClient;

  AuthBloc(this.httpClient) : super(null);

  @override
  AuthState get initialState => AuthLoading();

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    if (event is AuthLoading) {
      yield AuthLoading();
    } else if (event is Login) {
      yield LoginLoading();
      try {
        final result = await authRepository.login(
            email: event.email, password: event.password);
        if (result.status) {
          await authRepository.persistToken(result.token);
        } else {
          yield Unautheticated();
        }
      } catch (e) {
        yield LoginFailure(error: e.toString());
      }
    }
  }
}
