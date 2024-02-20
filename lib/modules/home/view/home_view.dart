import 'package:flutter/material.dart';
import 'package:local_file_transfer/modules/home/view_model/home_view_model.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key, required this.viewModel});

  final HomeViewModel viewModel;

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> implements HomeViewModelDelegate {
  HomeViewModel get viewModel => widget.viewModel;

  @override
  void initState() {
    viewModel.delegate = this;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("File Sharing"),
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                viewModel.navigateToSendView(context);
              },
              child: const SizedBox(
                width: 60,
                child: Text(
                  'Send',
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            const SizedBox(width: 16),
            ElevatedButton(
              onPressed: () {
                viewModel.navigateToReceiveView(context);
              },
              child: const SizedBox(
                width: 60,
                child: Text(
                  'Receive',
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.blueGrey,
    );
  }
}
