// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_product_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CartListHiveModelAdapter extends TypeAdapter<CartListHiveModel> {
  @override
  final int typeId = 0;

  @override
  CartListHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CartListHiveModel(
      id: fields[0] as int,
      title: fields[1] as String,
      price: fields[2] as double,
      image: fields[5] as String,
      category: fields[4] as String,
      description: fields[3] as String,
      localImage: fields[6] as String,
    );
  }

  @override
  void write(BinaryWriter writer, CartListHiveModel obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.price)
      ..writeByte(3)
      ..write(obj.description)
      ..writeByte(4)
      ..write(obj.category)
      ..writeByte(5)
      ..write(obj.image)
      ..writeByte(6)
      ..write(obj.localImage);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CartListHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
