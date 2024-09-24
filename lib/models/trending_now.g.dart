// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trending_now.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TrendingNowAdapter extends TypeAdapter<TrendingNow> {
  @override
  final int typeId = 2;

  @override
  TrendingNow read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TrendingNow(
      trendingItems: fields[0] as RecipeItems,
    );
  }

  @override
  void write(BinaryWriter writer, TrendingNow obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.trendingItems);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TrendingNowAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
