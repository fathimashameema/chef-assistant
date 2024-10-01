// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_status_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LoginStatusModelAdapter extends TypeAdapter<LoginStatusModel> {
  @override
  final int typeId = 7;

  @override
  LoginStatusModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LoginStatusModel(
      hasSeenIntro: fields[3] as bool,
      isAdmin: fields[0] as bool,
      isLogged: fields[1] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, LoginStatusModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.isAdmin)
      ..writeByte(1)
      ..write(obj.isLogged)
      ..writeByte(3)
      ..write(obj.hasSeenIntro);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LoginStatusModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
