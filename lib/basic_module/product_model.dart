class Product {
  final int id;
  final String title;
  final double price;
  final String image;
  final Rating rating;

  Product({
    required this.id,
    required this.title,
    required this.price,
    required this.image,
    required this.rating,
  });

  factory Product.fromMap(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      title: json['title'],
      price: (json['price'] as num).toDouble(),
      image: json['image'],
      rating: Rating.fromMap(json['rating']),
    );
  }
}

class Rating {
  final double rate;
  final int count;

  Rating({required this.rate, required this.count});

  factory Rating.fromMap(Map<String, dynamic> json) {
    return Rating(
      rate: (json['rate'] as num).toDouble(),
      count: json['count'],
    );
  }
}