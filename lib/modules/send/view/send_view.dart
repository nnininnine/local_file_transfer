import 'package:flutter/material.dart';
import 'package:local_file_transfer/modules/send/view_model/send_view_model.dart';

class SendView extends StatefulWidget {
  const SendView({super.key, required this.viewModel});

  final SendViewModel viewModel;

  @override
  State<SendView> createState() => _SendViewState();
}

class _SendViewState extends State<SendView> implements SendViewModelDelegate {
  SendViewModel get viewModel => widget.viewModel;

  @override
  void initState() {
    viewModel.delegate = this;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Send")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: viewModel.selectFile,
              child: const Text('Select File'),
            ),
            const SizedBox(height: 16),
            Text("Selected file: ${viewModel.selectedFilePath}"),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: viewModel.selectedFilePath != null ? () {} : null,
              child: const Text('Send'),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.deepPurple[200],
    );
  }
}
