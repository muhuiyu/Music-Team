class SongRecordKey {
  static const String id = 'id';
  static const String name = 'name';
  static const String note = 'note';
}

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
    return SongRecord(
        songId: json[SongRecordKey.id] as String,
        songName: json[SongRecordKey.name] as String,
        note: json[SongRecordKey.note] ?? '');
  }

  Map<String, dynamic> toJson() {
    return {
      SongRecordKey.id: songId,
      SongRecordKey.name: songName,
      SongRecordKey.note: note,
    };
  }
}
