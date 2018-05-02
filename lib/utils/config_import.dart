import 'package:jkd_flutter/model/api/api_interface.dart';
import 'package:jkd_flutter/theme.dart';

import 'utils.dart';

class ConfigImport {
  //do nothing
  String doSomething() {
    print(API.access_token);
    print(kAllGalleryThemes[0].name);
    showToast(null, "");
    return "";
  }
}
