import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod_pj/pages/welcome_page.dart';
import 'package:flutter_riverpod_pj/providers/blocs.dart';

class MyHomePage extends StatelessWidget {
  //Controladores de texto
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login Using Bloc'),
      ),
      body: Center(
        //widget de la libreria  para gestionar la UI  con los estados Cubit
        child: BlocBuilder<AuthCubit, AuthState>(
          builder: (context, state) {
            //Caso estado cargando
            if (state is AuthLoading) {
              return CircularProgressIndicator();
              //Caso autenticado correctamente
            } else if (state is AuthAuthenticated) {
              return WelcomePage();
              //Caso estado error
            } else if (state is AuthError) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Error: ${state.errorMessage}'),
                  ElevatedButton(
                    onPressed: () {
                      context.read<AuthCubit>().signOut();
                    },
                    child: Text('Volver a intentar'),
                  ),
                ],
              );
            } else {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextField(
                    controller: usernameController,
                    decoration: InputDecoration(labelText: 'Usuario'),
                  ),
                  TextField(
                    controller: passwordController,
                    decoration: InputDecoration(labelText: 'Contraseña'),
                    obscureText: true,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      //Obtenemos instancia y llamamos metodo signIn
                      context.read<AuthCubit>().signIn(
                            usernameController.text,
                            passwordController.text,
                          );
                    },
                    child: Text('Iniciar sesión'),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
