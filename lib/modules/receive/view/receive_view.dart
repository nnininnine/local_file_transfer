import 'package:flutter/material.dart';
import 'package:local_file_transfer/modules/receive/view_model/receive_view_model.dart';

class ReceiveView extends StatefulWidget {
  const ReceiveView({super.key, required this.viewModel});

  final ReceiveViewModel viewModel;

  @override
  State<ReceiveView> createState() => _ReceiveViewState();
}

class _ReceiveViewState extends State<ReceiveView> {
  ReceiveViewModel get viewModel => widget.viewModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Receive")),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
                onPressed: () {
                  print("on tap share hotspot");
                  viewModel.shareHotspot();
                },
                child: const Text("Share Hotspot"))
          ],
        ),
      ),
      backgroundColor: Colors.yellow[200],
    );
  }
}
