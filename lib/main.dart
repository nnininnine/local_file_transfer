import 'package:flutter/material.dart';
import 'package:local_file_transfer/modules/home/view/home_view.dart';
import 'package:local_file_transfer/modules/home/view_model/home_view_model.dart';

void main() {
  debugPrint = (String? message, {int? wrapWidth}) {};
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: HomeView(viewModel: HomeViewModel()),
    );
  }
}
