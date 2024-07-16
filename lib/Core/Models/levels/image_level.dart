// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:userboffee/Core/Models/basic_model.dart';

class ImageLevelModel extends ResultModel {
  String image;
  num ratio;
  ImageLevelModel({
    required this.image,
    required this.ratio,
  });

  ImageLevelModel copyWith({
    String? image,
    num? ratio,
  }) {
    return ImageLevelModel(
      image: image ?? this.image,
      ratio: ratio ?? this.ratio,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'image': image,
      'ratio': ratio,
    };
  }

  factory ImageLevelModel.fromMap(Map<String, dynamic> map) {
    return ImageLevelModel(
      image: map['image'] as String,
      ratio: map['ratio'] as num,
    );
  }

  String toJson() => json.encode(toMap());

  factory ImageLevelModel.fromJson(String source) => ImageLevelModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'ImageLevelModel(image: $image, ratio: $ratio)';

  @override
  bool operator ==(covariant ImageLevelModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.image == image &&
      other.ratio == ratio;
  }

  @override
  int get hashCode => image.hashCode ^ ratio.hashCode;
}
