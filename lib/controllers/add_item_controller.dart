import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class AddItemController extends GetxController {
  final ImagePicker _picker = ImagePicker();
  final RxString imagePath = ''.obs;

  Future<void> pickImage(ImageSource source) async {
    final XFile? image = await _picker.pickImage(source: source);
    imagePath.value = image?.path ?? '';
  }
}