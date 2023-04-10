import 'package:year_month_day/year_month_day.dart';
import 'package:music_roster_models/music_roster_models.dart';

UserModel testUser = UserModel(
    uid: 'user-1',
    roles: [UserRole.bass],
    name: 'Grace',
    email: 'grace@gmail.com',
    phone: '+6593483989');

// List<TeamNotification> notificationsTestEntries = [
//   TeamNotification(
//       id: 'team-notification-1',
//       title: 'Please sign up for March and April team!',
//       content: 'As I mentioned above, please sign up!'),
//   TeamNotification(
//       id: 'team-notification-2',
//       title: 'Roster is ready, team!',
//       content: 'Please check your slots.'),
// ];

ServiceModel serviceModelTestEntry = ServiceModel(
  date: YearMonthDay(year: 2023, month: 3, day: 5),
  rehearsalDates: [YearMonthDay(year: 2023, month: 3, day: 4)],
  duty: {
    UserRole.bass: [testUser]
  },
  songs: [
    SongRecord(
        songId: 'song-1',
        songName: '10,000 Reasons',
        note: 'on key E, play once'),
    SongRecord(
        songId: 'song-1',
        songName: '10,000 Reasons',
        note: 'on key E, play once'),
    SongRecord(
        songId: 'song-1',
        songName: '10,000 Reasons',
        note: 'on key E, play once'),
    SongRecord(
        songId: 'song-1',
        songName: '10,000 Reasons',
        note: 'on key E, play once'),
    SongRecord(
        songId: 'song-1',
        songName: '10,000 Reasons',
        note: 'on key E, play once'),
    SongRecord(
        songId: 'song-1',
        songName: '10,000 Reasons',
        note: 'on key E, play once'),
    SongRecord(
        songId: 'song-2',
        songName: 'Slient Night',
        note: 'on key G, only guitar and vocal'),
  ],
);
