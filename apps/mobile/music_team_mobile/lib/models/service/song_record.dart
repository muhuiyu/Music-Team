import 'package:music_team_mobile/api/providers/data_provider.dart';

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
        songId: json[DataProviderKey.songId] as String,
        songName: json[DataProviderKey.songName] as String,
        note: note);
  }
}
