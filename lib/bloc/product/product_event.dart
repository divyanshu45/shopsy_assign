abstract class ProductEvent {
  const ProductEvent();
}

class LoadProducts extends ProductEvent {}

class LoadProductById extends ProductEvent {
  final int productId;

  const LoadProductById(this.productId);
}
