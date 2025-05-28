import 'package:image_picker/image_picker.dart';

class UtilFunctions {
  static Future<String?> pickLocalImage({ImageSource imageSource = ImageSource.gallery}) async{
    try{
    final ImagePicker picker = ImagePicker();
    final image = await picker.pickImage(source: imageSource);
    return image?.path;
    }catch(ex){
      return null;
    }
  }
}