class SongKey {
  static const String name = 'name';
  static const String author = 'author';
  static const String musicLinkString = 'musicLinkString';
  static const String sheetLinkString = 'sheetLinkString';
}

class Song {
  String id;
  String name;
  String author;
  String musicLinkString;
  String sheetLinkString;

  Song({
    required this.id,
    required this.name,
    required this.author,
    required this.musicLinkString,
    required this.sheetLinkString,
  });

  factory Song.fromJson(String id, Map<String, dynamic> json) {
    return Song(
      id: id,
      name: json[SongKey.name],
      author: json[SongKey.author],
      musicLinkString: json[SongKey.musicLinkString],
      sheetLinkString: json[SongKey.sheetLinkString],
    );
  }

  Map<String, dynamic> get toJson {
    return {
      SongKey.name: name,
      SongKey.author: author,
      SongKey.musicLinkString: musicLinkString,
      SongKey.sheetLinkString: sheetLinkString,
    };
  }

  static Song get emptySong => Song(
      id: '', name: '', author: '', musicLinkString: '', sheetLinkString: '');
}
