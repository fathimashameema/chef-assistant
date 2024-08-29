// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_values.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserValuesAdapter extends TypeAdapter<UserValues> {
  @override
  final int typeId = 0;

  @override
  UserValues read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserValues(
      username: fields[0] as String,
      password: fields[1] as String,
      email: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, UserValues obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.username)
      ..writeByte(1)
      ..write(obj.password)
      ..writeByte(2)
      ..write(obj.email);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserValuesAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
