import 'package:flutter/services.dart' show rootBundle;

class TextForDisplay {
  late String returnedText;

  Future<String> getText(String path) async {
    String returnedText = await rootBundle.loadString(path);
    return returnedText;
  }
}
