part of 'product_detail_bloc.dart';

class ProductDetailEvent {
  const ProductDetailEvent();
}

class LoadProductDetail extends ProductDetailEvent {
  final int productId;

  const LoadProductDetail(this.productId);
}
