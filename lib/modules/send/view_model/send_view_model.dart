import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';

abstract class SendViewModelDelegate {
  void setState(VoidCallback fn);
}

class SendViewModel {
  // MARK: - Properties

  String? selectedFilePath;

  SendViewModelDelegate? delegate;

  // MARK: - Methods

  Future<void> selectFile() async {
    try {
      FilePickerResult? result =
          await FilePicker.platform.pickFiles(allowMultiple: true);
      if (result != null) {
        delegate?.setState(() {
          if (kDebugMode) {
            print(result.files.length);
          }
          selectedFilePath = result.files.single.path!;
        });
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error selecting flie: $e');
      }
    }
  }
}
