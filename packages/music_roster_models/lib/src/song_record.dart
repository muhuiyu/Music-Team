import 'package:music_roster_admin/api/providers/data_provider.dart';

class SongRecord {
  final String songId;
  final String songName;
  String note;

  SongRecord({
    required this.songId,
    required this.songName,
    this.note = '',
  });

  factory SongRecord.fromJson(Map<String, dynamic> json) {
    final String note = json[DataProviderKey.note] ?? '';
    return SongRecord(
        songId: json[DataProviderKey.id] as String,
        songName: json[DataProviderKey.name] as String,
        note: note);
  }

  Map<String, dynamic> toJson() {
    return {
      DataProviderKey.id: songId,
      DataProviderKey.name: songName,
      DataProviderKey.note: note,
    };
  }
}
