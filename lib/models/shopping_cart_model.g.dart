// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shopping_cart_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ShoppingCartModelAdapter extends TypeAdapter<ShoppingCartModel> {
  @override
  final int typeId = 6;

  @override
  ShoppingCartModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ShoppingCartModel(
      item: fields[0] as String,
    );
  }

  @override
  void write(BinaryWriter writer, ShoppingCartModel obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.item);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ShoppingCartModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
