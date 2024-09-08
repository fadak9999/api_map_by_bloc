import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:api_map_by_bloc/bloc/api_bloc.dart';
import 'package:api_map_by_bloc/API/ApiService.dart';
import 'package:api_map_by_bloc/PAGES/CategoryListScreen.dart'; 

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ApiBloc(ApiService()),
      child: const MaterialApp(
        
        debugShowCheckedModeBanner: false,
        home: CategoryListScreen(), 
      ),
    );
  }
}
