// class ProductDataModel {
//   final String id;
//   final String name;
//   final String description;
//   final double price;
//   final String imageUrl;
//   ProductDataModel({
//     required this.id,
//     required this.name,
//     required this.description,
//     required this.price,
//     required this.imageUrl,
//   });
// }

class ProductDataModel {
  final String id;
  final String name;
  final String description;
  final double price;
  final String imageUrl;
  final ProductDetails details;

  ProductDataModel({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.details,
  });
}

class ProductDetails {
  final String materialType;
  final String closureType;
  final String heelType;
  final String waterResistanceLevel;
  final String soleMaterial;
  final String style;
  final String countryOfOrigin;

  ProductDetails({
    required this.materialType,
    required this.closureType,
    required this.heelType,
    required this.waterResistanceLevel,
    required this.soleMaterial,
    required this.style,
    required this.countryOfOrigin,
  });
}
