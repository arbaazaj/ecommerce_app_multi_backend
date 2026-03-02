import 'package:equatable/equatable.dart';

class Category extends Equatable {
  final String id;
  final String name;
  final String? description;
  final String? imageUrl;
  final String? parentId;

  const Category({
    required this.id,
    required this.name,
    this.description,
    this.imageUrl,
    this.parentId,
  });

  @override
  List<Object?> get props => [id, name, description, imageUrl, parentId];
}
