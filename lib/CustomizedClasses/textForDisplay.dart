import 'package:flutter/services.dart' show rootBundle;

// A class to handle loading and returning text for display
class TextForDisplay {
  // Variable to hold the loaded text
  late String returnedText;

  // Method to load text from a given file path
  Future<String> getText(String path) async {
    // Loading string from path
    String returnedText = await rootBundle.loadString(path);
    return returnedText;
  }
}
