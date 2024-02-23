import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:local_file_transfer/modules/browse/view/browse_view.dart';

abstract class SendViewModelDelegate {
  void setState(VoidCallback fn);
}

class SendViewModel {
  // MARK: - Properties

  PlatformFile? selectedFile;

  SendViewModelDelegate? delegate;

  // MARK: - Methods

  Future<void> selectFile() async {
    try {
      FilePickerResult? result = await FilePicker.platform
          .pickFiles(allowMultiple: false, withData: true);
      if (result != null) {
        delegate?.setState(() {
          selectedFile = result.files.single;
        });
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error selecting flie: $e');
      }
    }
  }

  void share(BuildContext context) {
    if (selectedFile != null && selectedFile?.bytes != null) {
      _navigateToBrowseView(context, selectedFile!);
    }
  }

  void _navigateToBrowseView(BuildContext context, PlatformFile file) {
    Navigator.push(context, MaterialPageRoute(builder: ((context) {
      return BrowseView(file: file);
    })));
  }
}
