// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_items.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserItemsAdapter extends TypeAdapter<UserItems> {
  @override
  final int typeId = 4;

  @override
  UserItems read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserItems(
      title: fields[0] as String?,
      description: fields[1] as String?,
      prepTime: fields[2] as String?,
      ingredients: (fields[3] as List?)?.cast<String>(),
      directions: fields[4] as String?,
      categories: (fields[7] as List?)?.cast<String>(),
      image: fields[5] as Uint8List?,
      isVeg: fields[6] as bool?,
    );
  }

  @override
  void write(BinaryWriter writer, UserItems obj) {
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
      other is UserItemsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
