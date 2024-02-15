import 'package:flutter/material.dart';
import 'package:local_file_transfer/modules/home/view_model/home_view_model.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key, required this.viewModel});

  final HomeViewModel viewModel;

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Local File transfer"),
      ),
      body: Container(),
      backgroundColor: Colors.blueGrey,
    );
  }
}
