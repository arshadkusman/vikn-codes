import 'package:equatable/equatable.dart';
import '../../domain/entities/sale_item.dart';

abstract class SalesState extends Equatable {
  @override
  List<Object?> get props => [];
}

class SalesInitial extends SalesState {}

class SalesLoading extends SalesState {}

class SalesLoaded extends SalesState {
  final List<SaleItem> items;
  SalesLoaded(this.items);

  @override
  List<Object?> get props => [items];
}

class SalesFailure extends SalesState {
  final String message;
  SalesFailure(this.message);

  @override
  List<Object?> get props => [message];
}
