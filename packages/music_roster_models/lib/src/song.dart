import 'package:music_roster_admin/api/providers/data_provider.dart';

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
      name: json[DataProviderKey.name],
      author: json[DataProviderKey.author],
      musicLinkString: json[DataProviderKey.musicLinkString],
      sheetLinkString: json[DataProviderKey.sheetLinkString],
    );
  }

  Map<String, dynamic> get toJson {
    return {
      DataProviderKey.name: name,
      DataProviderKey.author: author,
      DataProviderKey.musicLinkString: musicLinkString,
      DataProviderKey.sheetLinkString: sheetLinkString,
    };
  }

  static Song get emptySong => Song(
      id: '', name: '', author: '', musicLinkString: '', sheetLinkString: '');
}
