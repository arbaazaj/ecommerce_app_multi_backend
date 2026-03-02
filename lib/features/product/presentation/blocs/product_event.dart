import 'package:equatable/equatable.dart';

abstract class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object?> get props => [];
}

class GetProductsEvent extends ProductEvent {
  final String? categoryId;
  final String? searchQuery;

  const GetProductsEvent({this.categoryId, this.searchQuery});

  @override
  List<Object?> get props => [categoryId, searchQuery];
}

class GetProductByIdEvent extends ProductEvent {
  final String id;

  const GetProductByIdEvent(this.id);

  @override
  List<Object?> get props => [id];
}
