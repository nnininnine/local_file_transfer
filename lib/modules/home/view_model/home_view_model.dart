import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_file_transfer/modules/receive/view/receive_view.dart';
import 'package:local_file_transfer/modules/receive/view_model/receive_view_model.dart';
import 'package:local_file_transfer/modules/receiver/receiver_view.dart';
import 'package:local_file_transfer/modules/send/view/send_view.dart';
import 'package:local_file_transfer/modules/send/view_model/send_view_model.dart';

abstract class HomeViewModelDelegate {
  void setState(VoidCallback fn);
}

class HomeViewModel {
  HomeViewModelDelegate? delegate;

  // MARK: Methods

  Future<void> textChannelFunc() async {
    const channelName = 'app.local_file_transfer.com/test_channel';
    const channel = MethodChannel(channelName);
    String value = await channel.invokeMethod("helloWorld");
    print(value);
  }

  void navigateToSendView(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: ((context) {
      return SendView(viewModel: SendViewModel());
    })));
  }

  void navigateToReceiveView(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: ((context) {
      return ReceiveView(viewModel: ReceiveViewModel());
    })));
  }

  void navigateToReceiverView(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: ((context) {
      return const ReceiverView();
    })));
  }
}
