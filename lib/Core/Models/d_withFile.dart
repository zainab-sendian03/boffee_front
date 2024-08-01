
import 'package:userboffee/Core/Models/detial_model.dart';

class Detail_withFile {
  DetailModel? file;
  int? shelfId;

  Detail_withFile({this.file, this.shelfId});

  Detail_withFile.fromJson(Map<String, dynamic> json) {
    file = json['file'] != null ? DetailModel.fromJson(json['file']) : null;
    shelfId = json['shelf_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (file != null) {
      data['file'] = file!.toJson();
    }
    data['shelf_id'] = shelfId;
    return data;
  }
}