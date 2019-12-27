import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
class Genre extends Equatable {
  final int id;
  final String name;

  Genre({
    @required this.id,
    @required this.name
  });

  @override
  List<Object> get props => [id,name];

}