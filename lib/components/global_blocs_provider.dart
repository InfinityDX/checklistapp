import 'package:checklistapp/bloc/page_cubit/page_cubit.dart';
import 'package:checklistapp/bloc/theme_cubit/theme_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GlobalBlocsProvider extends StatelessWidget {
  final Widget child;
  const GlobalBlocsProvider({required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => PageCubit()),
        BlocProvider(create: (context) => ThemeCubit()),
      ],
      child: child,
    );
  }
}
