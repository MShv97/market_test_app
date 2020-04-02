class Product {
  Product(
      {this.id,
      this.img,
      this.desc,
      this.name,
      this.price,
      this.stoke,
      this.isSelected}) {
    this.isSelected = false;
  }

  final String id;
  final String img;
  final String name;
  final String price;
  final String desc;
  final String stoke;
  bool isSelected;

  Map<String, String> toJson() => {
        'id': this.id,
      };
}
