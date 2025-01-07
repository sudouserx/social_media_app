import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/features/auth/data/firebase_auth_repo.dart';
import 'package:social_media_app/features/auth/presentation/cubits/auth_cubit.dart';
import 'package:social_media_app/features/auth/presentation/cubits/auth_states.dart';
import 'package:social_media_app/features/auth/presentation/pages/auth_page.dart';
import 'package:social_media_app/features/post/presentation/pages/home_page.dart';
import 'package:social_media_app/themes/light_mode.dart';

/**

App - Root level

-----------------------------------------------------

Repositories: for the database
  - firebase

Bloc provider - for state management
  auth
  profile
  post
  search
  theme

check Auth state
  unauthenticated --> auth page (login/ register)
  authenticated--> home page
 */

class MyApp extends StatelessWidget {
  //auth repo
  final authRepo = FirebaseAuthRepo();

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // provide the cubit to our app
    return BlocProvider(
      create: (context) => AuthCubit(authRepo: authRepo)..checkAuth(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: lightMode,
        home: Scaffold(
          body:
              BlocConsumer<AuthCubit, AuthState>(builder: (context, authState) {
            print(authState);
            if (authState is Unauthenticated) {
              return const AuthPage();
            }

            if (authState is Authenticated) {
              return const HomePage();
            } else {
              // loading
              return const Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
          }, 
          // listen for any error while we login
          listener: (context, state) {
            if (state is AuthError) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(state.message)));
            }
          }),
        ),
      ),
    );
  }
}
