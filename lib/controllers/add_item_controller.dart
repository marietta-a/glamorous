import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class AddItemController extends GetxController {
  final ImagePicker _picker = ImagePicker();

  Future<void> pickImage(ImageSource source) async {
    final XFile? image = await _picker.pickImage(source: source);
    if (image != null) {
      // Proceed to the ItemDetailsScreen with the picked image
      // Get.toNamed(Routes.ITEM_DETAILS, arguments: image.path);
      print("Image picked: ${image.path}");
    }
  }
}