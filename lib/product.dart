
class Product {
  final String name;
  final String price;
  final bool active;
  final String id;
  int qty=1;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.active,
  });

  Map<String, dynamic> toMap(){
    return{
      'id': id,
      'name': name,
      'price': price,
      'qty': qty,
    };
  }
}