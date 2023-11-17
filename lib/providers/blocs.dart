import 'package:flutter_bloc/flutter_bloc.dart';
// Estados
//Representar diferentes estados
abstract class AuthState {}
//Estado autenticado
class AuthAuthenticated extends AuthState {}
//Estado no autenticado
class AuthUnauthenticated extends AuthState {}
//Estado cargando
class AuthLoading extends AuthState {}
//Estado error
class AuthError extends AuthState {
  final String errorMessage;

  AuthError(this.errorMessage);
}

// Eventos
abstract class AuthEvent {}
//Evento de intento de sesion
class AuthSignInEvent extends AuthEvent {
  final String username;
  final String password;

  AuthSignInEvent(this.username, this.password);
}
//Evento para cerrar sesion
class AuthSignOutEvent extends AuthEvent {}

// Cubit
class AuthCubit extends Cubit<AuthState> {
  //Inicializar constructor en No Autorizado
  AuthCubit() : super(AuthUnauthenticated());
  //metodo para iniciar sesion
  void signIn(String username, String password) {
    emit(AuthLoading());

    // autenticación exitosa con las credenciales correctas
    if (username == "user" && password == "cisco") {
      emit(AuthAuthenticated());
    } else {
      emit(AuthError("Usuario o contraseña incorrectos"));
    }
  }
  //Metodo para gestionar cerrar sesion
  void signOut() {
    emit(AuthUnauthenticated());
  }
}
