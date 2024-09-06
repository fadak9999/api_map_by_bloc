

class MyCategory {
  final String id;
  final String name;
  final String colorHex;
  final String iconId;
  final String image;
  final String locationCount;
  final List<CategoryLocation> locations;

  MyCategory({
    required this.id,
    required this.name,
    required this.colorHex,
    required this.iconId,
    required this.image,
    required this.locationCount,
    required this.locations,
  });

  factory MyCategory.fromJson(Map<String, dynamic> json) {
    var locationsFromJson = json['locations'] as List;
    List<CategoryLocation> locationList = locationsFromJson
        .map((i) => CategoryLocation.fromJson(i))
        .toList();

    return MyCategory(
      id: json['Id'].toString(),
      name: json['name'],
      colorHex: json['color_hex'],
      iconId: json['icon_Id'].toString(),
      image: json['image'],
      locationCount: json['location_count'].toString(),
      locations: locationList,
    );
  }
}
//
class CategoryLocation {
  final String id;
  final String name;
  final String googleLatitude;
  final String googleLongitude;
  final String description;
  final String categoryName;
  final String colorHex;
  final String iconId;
  final String image;

  CategoryLocation({
    required this.id,
    required this.name,
    required this.googleLatitude,
    required this.googleLongitude,
    required this.description,
    required this.categoryName,
    required this.colorHex,
    required this.iconId,
    required this.image,
  });

  factory CategoryLocation.fromJson(Map<String, dynamic> json) {
    return CategoryLocation(
      id: json['Id'].toString(),
      name: json['name'],
      googleLatitude: json['google_latitude'],
      googleLongitude: json['google_longitude'],
      description: json['description'],
      categoryName: json['category_name'],
      colorHex: json['color_hex'],
      iconId: json['icon_Id'].toString(),
      image: json['image'],
    );
  }
}
