import 'package:flutter/material.dart';
import 'package:local_file_transfer/modules/receive/view/receive_view.dart';
import 'package:local_file_transfer/modules/receive/view_model/receive_view_model.dart';
import 'package:local_file_transfer/modules/send/view/send_view.dart';
import 'package:local_file_transfer/modules/send/view_model/send_view_model.dart';

abstract class HomeViewModelDelegate {
  void setState(VoidCallback fn);
}

class HomeViewModel {
  HomeViewModelDelegate? delegate;

  // MARK: Methods

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
}
