// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recipe_items.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RecipeItemsAdapter extends TypeAdapter<RecipeItems> {
  @override
  final int typeId = 1;

  @override
  RecipeItems read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return RecipeItems(
      isVeg: fields[6] as bool?,
      title: fields[0] as String?,
      description: fields[1] as String?,
      prepTime: fields[2] as String?,
      ingredients: (fields[3] as List?)?.cast<String>(),
      directions: fields[4] as String?,
      image: fields[5] as Uint8List?,
      categories: (fields[7] as List?)?.cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, RecipeItems obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.description)
      ..writeByte(2)
      ..write(obj.prepTime)
      ..writeByte(3)
      ..write(obj.ingredients)
      ..writeByte(4)
      ..write(obj.directions)
      ..writeByte(5)
      ..write(obj.image)
      ..writeByte(6)
      ..write(obj.isVeg)
      ..writeByte(7)
      ..write(obj.categories);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RecipeItemsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
